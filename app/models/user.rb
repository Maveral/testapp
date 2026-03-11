require "open-uri"
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  
  # Active Storage dla zdjęcia profilowego
  has_one_attached :avatar

  # Action Text dla bogatego opisu (opcjonalnie)
  has_rich_text :bio
  
  # Opcjonalna walidacja formatu i rozmiaru
  validates :avatar, content_type: ['image/png', 'image/jpeg'],
                     size: { less_than: 5.megabytes , message: 'jest za duży' }

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |u|
      u.email = auth.info.email
      u.password = Devise.friendly_token[0, 20]
      u.name = auth.info.name.split(' ').first
      u.surname = auth.info.name.split(' ').last
    end

    # Avatar doczepiamy PO utworzeniu/znalezieniu użytkownika, 
    # jeśli jeszcze go nie ma i Google dostarczyło URL
    if auth.info.image.present? && !user.avatar.attached?
      begin
        # Otwieramy URL jako plik tymczasowy
        file = URI.open(auth.info.image)
        
        # Attach wymaga: io (dane), filename (nazwa) i opcjonalnie content_type
        user.avatar.attach(
          io: file, 
          filename: "avatar_#{user.uid}.jpg", 
          content_type: "image/jpeg"
        )
      rescue OpenURI::HTTPError => e
        logger.error "Nie udało się pobrać awatara: #{e.message}"
      end
    end

    user
  end
end

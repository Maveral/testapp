// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

// Dodanie przycisku do paska narzędzi
Trix.config.textAttributes.underline = {
  tagName: "u",
  inheritable: true,
  parser: function(element) {
    return element.tagName.toLowerCase() === "u"
  }
}

document.addEventListener("trix-initialize", function(event) {
  const buttonHTML = '<button type="button" class="trix-button" data-trix-attribute="underline" title="Underline">U</button>'
  event.target.toolbarElement.querySelector(".trix-button-group--text-tools").insertAdjacentHTML("beforeend", buttonHTML)
})
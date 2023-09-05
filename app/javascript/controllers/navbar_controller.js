import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = [ "navbar" ]
  connect() {
  }

  open() {
    this.navbarTarget.classList.remove('hidden')
  }

  close() {
    this.navbarTarget.classList.add('hidden')
  }
}

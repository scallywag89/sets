import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "album", "track" ]

  connect() {
    console.log("Hello from SearchBar controller")
  }

  selectSearch() {
    this.albumTarget.classList.toggle("btn-default");
    this.albumTarget.classList.toggle("btn-primary");
    this.trackTarget.classList.toggle("btn-default");
    this.trackTarget.classList.toggle("btn-primary");
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    console.log("Hello from our first Stimulus controller")
  }

  selectSearch() {
    console.log(this.inputTarget.checked);
    this.element.addEventListener('change', (e) => {
      console.log(e.target.checked)
    }
  }

}

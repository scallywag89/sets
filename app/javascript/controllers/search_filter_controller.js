import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["album", "track"]

  filter(e) {
    console.log(e.target.dataset.type)
    if (e.target.innerText === "Albums") { // if clicked albums
      const search = document.querySelectorAll(".search-card")
      e.target.classList.add("active")
      this.trackTarget.classList.remove("active")
      search.forEach((card) => { // remove tracks from display
        if (card.dataset.type == "track") {
          card.style.display = "none"
        }
        if (card.dataset.type == "album") {
          card.style.display = "inline-block"
        }
      })
    }
    if (e.target.innerText === "Tracks") { // if clicked tracks
      const search = document.querySelectorAll(".search-card")
      e.target.classList.add("active")
      this.albumTarget.classList.remove("active")
      search.forEach((card) => { // remove albums from display
        if (card.dataset.type == "album") {
          card.style.display = "none"
        }
        if (card.dataset.type == "track") {
          card.style.display = "flex"
        }
      })
    }
  }
}

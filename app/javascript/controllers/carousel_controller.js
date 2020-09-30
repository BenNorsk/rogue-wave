import { Controller } from "stimulus"

console.log(">>> Hello from Stimulus Controller | carousel ")
export default class extends Controller {
  static targets = [ "slide" ]

  //1
  initialize() {
    console.log(this.slideTargets)
    this.showCurrentSlide()
  }

  next() {
    debugger
    console.log(this.index)
    this.index === this.slideTargets.length ? 
    this.index++
  }

  previous() {
    console.log(this.index)
    this.index--
  }

  //2
  showCurrentSlide() {
    this.slideTargets.forEach((element, i) => {
      // add/remove slide--current, depending on test conditional, element.index == iteration
      element.classList.toggle("slide--current", this.index == i)
    })
  }

  get index() {
    return parseInt(this.data.get("index"))
  }

  set index(value) {
    this.data.set("index", value)
    this.showCurrentSlide()
  }
}
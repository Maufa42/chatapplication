import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  reset() {
    // console.log("INSIDE CONTROLLER");
    this.element.reset()
  }
}

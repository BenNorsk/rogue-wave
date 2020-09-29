// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["source"]

  connect() {
    console.log("controller connected to: ", this.element);
    if (document.queryCommandSupported("copy")) {
      this.element.classList.add("clipboard--supported")
    }
  }

  pasteIndex() {
    let index = this.data.get('index');
    this.sourceTarget.value = index;
  }

  copy() {
    this.sourceTarget.select();
    document.execCommand("copy");
  }
}

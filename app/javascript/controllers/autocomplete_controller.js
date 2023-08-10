import { Autocomplete } from "stimulus-autocomplete"

export default class extends Autocomplete {
  connect() {
    super.connect()
    console.log("Autocomplete controller connected!");
    this.inputTarget.addEventListener('focus', () => {
      if (!this.inputTarget.value) {
         let event = new Event('input', { 'bubbles': true, 'cancelable': true });
         this.inputTarget.dispatchEvent(event);
      }
   })
   
  }
}

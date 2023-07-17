import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price"
export default class extends Controller {
  static targets = ["startTime", "endTime", "price", "total", "lasttotal"]
  connect() {
    console.log("check")
  }
  calculate() {
    const n = parseInt(this.priceTarget.innerText, 10)

    const start = new Date(this.startTimeTarget.value)
    const end = new Date(this.endTimeTarget.value)
    const time = end.getDate() - start.getDate()

    let total1 = n * time
    let total2 = total1 + 30

    this.totalTarget.innerText = total1
    this.lasttotalTarget.innerText = total2
  }
}

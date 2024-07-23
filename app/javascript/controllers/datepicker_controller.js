import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    // Get the booked date ranges from the embedded JavaScript variable
    const bookedDateRanges = window.bookedDateRanges || [];
    console.log("Inside Stimulus Controller:", bookedDateRanges);

    flatpickr(this.element, {
      dateFormat: "d-m-Y",
      minDate: "today", // Prevents past dates
      disable: [
        function(date) {
          // Check if the date falls within any of the booked date ranges
          return bookedDateRanges.some(range => {
            const startDate = new Date(range[0]);
            const endDate = new Date(range[1]);
            startDate.setHours(0, 0, 0, 0);
            endDate.setHours(23, 59, 59, 999);
            return date >= startDate && date <= endDate;
          });
        }
      ]
    });
  }
}

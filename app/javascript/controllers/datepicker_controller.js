import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    this.initializeDatePickers();
  }

  initializeDatePickers() {
    const bookedDateRanges = JSON.parse(this.element.dataset.bookedDateRanges) || [];
    console.log("Inside Stimulus Controller:", bookedDateRanges);

    this.initializeStartDatePicker(bookedDateRanges);
    this.initializeEndDatePicker(bookedDateRanges);
  }

  initializeStartDatePicker(bookedDateRanges) {
    flatpickr("#booking_start_date", {
      dateFormat: "d-m-Y",
      minDate: "today",
      disable: this.getDisableDates(bookedDateRanges),
      onChange: (selectedDates) => {
        const endDatePicker = document.getElementById("booking_end_date")._flatpickr;
        if (selectedDates.length > 0) {
          const minEndDate = new Date(selectedDates[0].getTime() + 24 * 60 * 60 * 1000);
          endDatePicker.set('minDate', minEndDate);
        } else {
          endDatePicker.set('minDate', "today");
        }
      },
      allowInput: false
    });
  }

  initializeEndDatePicker(bookedDateRanges) {
    flatpickr("#booking_end_date", {
      dateFormat: "d-m-Y",
      minDate: "today",
      disable: this.getDisableDates(bookedDateRanges),
      allowInput: false
    });
  }

  getDisableDates(bookedDateRanges) {
    return [
      function(date) {
        return bookedDateRanges.some(range => {
          const startDate = new Date(range[0]);
          const endDate = new Date(range[1]);
          startDate.setHours(0, 0, 0, 0);
          endDate.setHours(23, 59, 59, 999);
          return date >= startDate && date <= endDate;
        });
      }
    ];
  }

  updateBookedDates(newBookedDateRanges) {
    window.bookedDateRanges = newBookedDateRanges;
    this.initializeDatePickers();
  }
}

// Example usage of updating the booked dates dynamically
function fetchBookedDates() {
  fetch('/path/to/your/api/endpoint')
    .then(response => response.json())
    .then(data => {
      const controller = document.querySelector('[data-controller="datepicker"]').controller;
      if (controller) {
        controller.updateBookedDates(data.bookedDateRanges);
      }
    });
}

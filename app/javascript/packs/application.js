// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"

Rails.start()

document.addEventListener('DOMContentLoaded', () => {
  const askButton = document.getElementById('ask-button')
  const askForm = document.getElementById('ask-form')

  askButton.addEventListener('click', (event) => {
    event.preventDefault()

    setTimeout(() => {
      const displayStyle = askForm.style.display === 'block' ? 'none' : 'block'
      askForm.style.display = displayStyle
    }, 300)
  })
})

let slideIndex = 0;
const slides = document.getElementsByClassName("banner-slide");

// Start the slideshow
showSlides();

function showSlides() {
  // Set all slides to inactive
  for (let i = 0; i < slides.length; i++) {
    slides[i].classList.remove("active");
  }
  // Increment slide index
  slideIndex++;
  // Loop back to the first slide if at the end
  if (slideIndex > slides.length) {
    slideIndex = 1;
  }
  // Set the current slide to active
  slides[slideIndex - 1].classList.add("active");
  // Call showSlides again after a delay
  setTimeout(showSlides, 5000);
}

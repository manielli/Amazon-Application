import anime from "animejs";

// console.log("Product index javascript loaded!");

document.addEventListener("DOMContentLoaded", () => {
    anime({
        targets: ".product-list > li",
        opacity: 1,
        duration: 50,
        delay: anime.stagger(50)
    })
});
import anime from "animejs";
import tippy from "tippy.js";
import "tippy.js/dist/tippy.css";

// console.log("Product index javascript loaded!");

document.addEventListener("DOMContentLoaded", () => {
    anime({
        targets: ".product-list > li",
        opacity: 1,
        duration: 100,
        delay: anime.stagger(50)
    })

    document.querySelectorAll(".product-list > li > a").forEach(node => {
        let a = node;
        node.addEventListener("mouseover", event => {
            const { currentTarget } = event;

            // console.log(currentTarget);
            currentTarget.setAttribute("data-tippy-content", currentTarget.innerHTML);
            
            // tippy(a);
        });
    });

});
import anime from "animejs";
// console.log("Product show javascript loaded");

document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".review-delete-btn").forEach(node => {
        node.addEventListener("click", event => {
            event.preventDefault();

            const { currentTarget } = event;
            const reviewId = currentTarget.dataset.id;
            // console.log("Clicked!", event.currentTarget);

            if (!confirm("Are you sure you want to delete this review?")) {
                return;
            }
            fetch(`/api/v1/reviews/${reviewId}`, { 
                credentials: "same-origin",
                method: "DELETE"
            }).then(() => {
                // console.log("Review deleted");
                // document.querySelector(`#review_${reviewId}`).remove();
                const reviewLi = document.querySelector(`#review_${reviewId}`);

                anime({
                    targets: reviewLi,
                    opacity: 0,
                    duration: 100,
                    easing: "linear"
                }).finished.then(() => {
                    reviewLi.remove();
                });
            });
        });
    });
});
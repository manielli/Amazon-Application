import React, { Component } from "react";


class ProductReviews extends Component {
    constructor(props) {
        super(props);

        this.state = {
            reviews: {...this.props.reviews}
        }
    }

    render () {
        console.log(...this.state.reviews);
        return (
            <main>
                <h1>Reviews List, Again!:</h1>
                <ul>
                    <li>
                        Reviews
                    </li>
                </ul>
            </main>
        );
    };
}

export default ProductReviews;
import React from "react";

const HelloWorld = props => {
    return (
        <h2>Hello, {props.name || "World"}!</h2>
    );
};

export default HelloWorld;
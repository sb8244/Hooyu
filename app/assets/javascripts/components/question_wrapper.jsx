import React from "react";
import Answer from "./answer.jsx";

class QuestionWrapper extends React.Component {
  render() {
    return (
      <div>
        <header>{this.props.question}</header>
        <ul>{this.props.choices.map(this.renderAnswer)}</ul>
      </div>
    );
  }

  renderAnswer(choice, i) {
    return (
      <Answer key={i} content={choice} />
    );
  }
}

export default QuestionWrapper;

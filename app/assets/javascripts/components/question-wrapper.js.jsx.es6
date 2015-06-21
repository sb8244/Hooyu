class QuestionWrapper extends React.Component {
  render() {
    return (
      <div>
        <header>{this.props.question}</header>
        <ul>{this.props.choices.map(this.renderChoice)}</ul>
      </div>
    );
  }

  renderChoice(choice, i) {
    return (
      <li key={i}>{choice}</li>
    );
  }
}

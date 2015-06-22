class Answer extends React.Component {
  render() {
    return (
      <li onClick={this.onClick.bind(this)}>{this.props.content}</li>
    );
  }

  onClick() {
    $.post("/answers", { answer: this.props.content }).then((response) => {
      window.location.reload();
    });
  }
}

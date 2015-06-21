class PersonImage extends React.Component {
  render() {
    return (
      <div className="full-width-img-wrapper">
        <img src={this.props.src} className="img-responsive img-circle" />
      </div>
    );
  }
}

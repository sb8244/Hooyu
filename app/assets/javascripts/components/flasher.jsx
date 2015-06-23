import React from "react";

class Flasher extends React.Component {
  render() {
    return (
      <div className="flasher">{this.props.message}</div>
    );
  }
}

export default Flasher;

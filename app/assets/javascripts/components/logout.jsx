import React from "react";

class Logout extends React.Component {
  render() {
    return (
      <div id="logout">
        <a href={this.props.url}>Logout</a>
      </div>
    );
  }
}

export default Logout;

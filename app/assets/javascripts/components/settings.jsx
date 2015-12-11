import React from "react";

class Settings extends React.Component {
  render() {
    return (
      <div id="settings">
        <a href={this.props.url}>Your Info</a>
      </div>
    );
  }
}

export default Settings;

import React from "react";
import Notification from "react-notification-system";

class Flasher extends React.Component {
  componentDidMount() {
    this.refs.notification.addNotification({
      message: this.props.message,
      position: "bc",
      level: this.props.success ? "success" : "error"
    });
  }

  render() {
    return ( <Notification  ref="notification"/> );
  }
}

export default Flasher;

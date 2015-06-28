import React from "react";

class Stats extends React.Component {
  render() {
    return (
      <div id="stats">
        { this.props.stats.knows } / { this.props.stats.total }
      </div>
    );
  }
}

export default Stats;

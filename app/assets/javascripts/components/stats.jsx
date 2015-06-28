import React from "react";

class Stats extends React.Component {
  render() {
    return (
      <div id="stats">
        You know { this.props.stats.knows } / { this.props.stats.total } people
      </div>
    );
  }
}

export default Stats;

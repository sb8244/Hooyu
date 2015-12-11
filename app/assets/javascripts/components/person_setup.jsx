import React from 'react';
import $ from 'jquery';
import Select from 'react-select';

var defaultUri = "data:image/png;base64,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";

class PersonSetup extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      email: props.details.email,
      organization_name: props.details.organization_name,
      first_name: props.details.first_name,
      last_name: props.details.last_name,
      department: props.details.department,
      dataUri: props.details.image_url ? props.details.image_url : defaultUri,
      token: $('meta[name="csrf-token"]').attr('content')
    };

    this.setFirstName = this.setFirstName.bind(this);
    this.setLastName = this.setLastName.bind(this);
    this.handleFile = this.handleFile.bind(this);
    this.setDepartment = this.setDepartment.bind(this);
  }

  setFirstName(event) {
    this.setState({first_name: event.target.value});
  }

  setLastName(event) {
    this.setState({last_name: event.target.value});
  }

  setDepartment(val) {
    this.setState({department: val});
  }

  handleFile(event) {
    var reader = new FileReader();
    var file = event.target.files[0];

    reader.onload = (upload) => {
      this.setState({
        dataUri: upload.target.result
      });
    };

    reader.readAsDataURL(file);
  }

  render() {
    var title = this.props.existing ? "Confirm Information" : "Setup Account";
    var imageRequired = !this.props.details.image_url;

    return (
      <div className="row">
        <div className="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3">
          <div className="panel panel-default">
            <div className="panel-heading">
              <div className="panel-title">{ title }</div>
            </div>

            <div className="panel-body">
              <form method="POST" url={this.props.saveUrl} encType="multipart/form-data">
                <input type="hidden" name="authenticity_token" value={this.state.token} />

                <div className="form-group">
                  <label>Email Address</label>
                  <input type="email" name="email" className="form-control" readOnly={true} value={this.state.email} />
                </div>

                <div className="form-group">
                  <label>Organization</label>
                  <input type="text" className="form-control" readOnly={true} value={this.state.organization_name} />
                </div>

                <div className="form-group">
                  <label htmlFor="first_name">First Name</label>
                  <input type="text" name="first_name" className="form-control" id="first_name"
                    value={this.state.first_name} onChange={this.setFirstName} required={true} />
                </div>

                <div className="form-group">
                  <label htmlFor="last_name">Last Name</label>
                  <input type="text" name="last_name" className="form-control" id="last_name"
                    value={this.state.last_name} onChange={this.setLastName} required={true} />
                </div>

                <div className="form-group">
                  <label htmlFor="department">Department</label>
                  <Select name="department" value={this.state.department} options={this.departmentOptions()} onChange={this.setDepartment} />
                </div>

                <div className="form-group">
                  <label htmlFor="profile_image">Clean, Recognizable Image of You</label>
                  <input type="file" name="profile_image" id="profile_image" onChange={this.handleFile} placeholder="X" required={imageRequired} />
                  <img src={this.state.dataUri} className="setup-image" />
                </div>

                <button className="btn btn-primary btn-block">Save & Get Started</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    );
  }

  departmentOptions() {
    return this.props.departments.map((department) => {
      return { value: department, label: department };
    });
  }
}

export default PersonSetup;

import $ from "jquery";
import PersonImage from "./components/person_image.jsx";
import QuestionWrapper from "./components/question_wrapper.jsx";
import Flasher from "./components/flasher.jsx";
import React from "react";
require("./react_ujs.js");

window.PersonImage = PersonImage;
window.QuestionWrapper = QuestionWrapper;
window.Flasher = Flasher;

$.ajaxPrefilter(function( options ) {
  if ( !options.beforeSend) {
    options.beforeSend = function (xhr) {
      xhr.setRequestHeader('X-CSRF-Token',  $('meta[name="csrf-token"]').attr('content'));
    }
  }
});

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 
require("@nathanvda/cocoon")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import Raty from "raty.js"
window.raty = function(elem,opt) {
    let raty =  new Raty(elem,opt)
    raty.init();
    return raty;
}

document.addEventListener("turbolinks:load", () => {
    const gmlRecipes = document.querySelectorAll('.gml-recipes')
    const state = [...gmlRecipes].map( o => ({ id: o.id, value: parseFloat(o.value) }) )
    gmlRecipes.forEach( gml => {
        gml.addEventListener('change', e => {
            const changedGmlId = gml.id
            const changedGmlValue = gml.value
            const changedForm = state.find( o => o.id == changedGmlId )
            const coef = changedGmlValue / changedForm.value
            const changedState = state.map( o => ({ id: o.id, value: o.value * coef }))
            gmlRecipes.forEach( (o, i) => {
                o.value = changedState[i].value.toFixed(1)
            })
        })
    })
})
# 
# Fake gravity express app
# 

_ = require 'underscore'
express = require 'express'
fabricate = require './fabricate'
{ spawn } = require 'child_process'
path = require 'path'

gravity = module.exports = express()

gravity.get '/api/v1/artwork/:id', (req, res) ->
  res.send fabricate 'artwork', title: 'Main artwork!'

gravity.get '/api/v1/post/:id', (req, res) ->
  res.send fabricate 'post', title: 'Main post!'

gravity.get '/api/v1/related/posts', (req, res) ->
  res.send [fabricate('post', title: 'Related post!'), fabricate('post')]

gravity.get '/api/v1/related/layer/synthetic/main/artworks', (req, res) ->
  res.send [fabricate('artwork', title: 'Suggested artwork!'), fabricate('artwork')]

gravity.get '/api/v1/xapp_token', (req, res) ->
  res.send { xapp_token: 'xapp_foobar', expires_in: 'expires in utc string' }

gravity.get '/unsupported_route', (req, res) ->
  res.send "I'm in ur microgravitiez rendering ur pagez!"

gravity.get '/api/v1/match', (req, res) ->
  res.send [fabricate('artwork', value: 'Skull', model: 'artwork')]

gravity.get '/api/v1/admins/available_representatives', (req, res) ->
  res.send [fabricate('user')]

gravity.get '/api/v1/profile/alessandra', (req, res) ->
  res.send fabricate('profile')

gravity.get '/api/v1/fair/:id', (req, res) ->
  res.send fabricate('fair')

gravity.get '/api/v1/fair/:id/sections', (req, res) ->
  res.send [
    { section: "FOCUS", partner_shows_count: 13 }
    { section: "Pier 92", partner_shows_count: 42 }
  ]

gravity.get '/api/v1/fair/:id/shows', (req, res) ->
  res.send results: [fabricate('show', 
    fair: fabricate('fair')
    fair_location: { display: 'Dock 4' }
    artworks: [fabricate('artwork')]
  )]

gravity.get '/api/v1/sets', (req, res) ->
  res.send [fabricate('set')]

gravity.get '/api/v1/set/:id/items', (req, res) ->
  res.send [fabricate('featured_link'), fabricate('featured_link')]

gravity.get '/api/v1/profile/:id', (req, res) ->
  if req.params.id is 'thearmoryshow'
    res.send fabricate 'profile',
      owner_type: 'FairOrganizer'
      owner: { default_fair_id: 'the-armory-show' }
  else if req.params.id is 'gagosian-gallery'
    res.send fabricate 'profile',
      owner_type: 'PartnerGallery'
      owner: fabricate('partner', id: 'gagosian-gallery')
  else
    res.send fabricate('profile', owner_type: 'User')

gravity.get '/api/v1/partner/:id/shows', (req, res) ->
  res.send [fabricate('show', status: 'closed'), fabricate('show', status: 'running')]  

gravity.get '/api/v1/search/filtered/fair/:id/options', (req, res) ->
  res.send { medium: { Painting: 'painting' } }

gravity.get '/api/v1/search/filtered/fair/:id/suggest', (req, res) ->
  res.send { medium: { painting: 420 } }

gravity.get '/api/v1/profile/alessandra/posts', (req, res) ->
  res.send [fabricate 'post']

gravity.get '/api/v1/page/:id', (req, res) ->
  res.send fabricate 'page', content: 'This *page* is awesome!'

gravity.get '/local/*', (req, res) ->
  res.send 'img.jpg'

gravity.all '*', (req, res) -> res.send 404, "Not Found."
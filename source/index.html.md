---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - python
  - shell

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true
---
<!-- - ruby -->
# Introducción

Integra las aplicaciones de redfenix con F-API. Este API de Redfenix te permite obtener Ads para cuando un user se conecte a los sitios, crear nuevos sitios, editarlos, eliminarlos. Además de operaciones similares para los Ads (Pautas).

Está diseñado como un servicio web REST. Para comunicarte con nuestra API sólo necesitas cualquier lenguaje que provea un cliente HTTP.

Todos las operaciones responden en formato JSON, incluso los errores.

# Authenticación

<!-- > To authorize, use this code:

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
```

```shell
# With shell, you can just pass the correct header with each request
curl "api_endpoint_here"
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
```
-->

Para obtener tu clave del API deberás solicitarla al equipo de desarrollo de Redfenix, posteriormente la podrás obtener directamente desde nuestro administrador.

Nuestra API espera que en el encabezado de cada request se le envíe el siguiente atributo:

`Authorization: apiKeyGenerated`

<aside class="notice">
Debes reemplazar <code>apiKeyGenerated</code> con tu API key personal.
</aside>

# Ads

## Obtener Ads de un Sitio

<!-- ```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.get
``` -->

```python
import requests

url = "https://f-api.redfenix.ec/ads"

querystring = {"user":"BB:BB:BB:BB:BB:C0","site":"dnsofsite.redfenix.ec","ip_local":"127.0.0.1"}

headers = {'authorization': 'apiKeyGenerated'}

response = requests.request("GET", url, headers=headers, params=querystring)

print(response.text)

```

```shell
curl --request GET \
  --url 'https://f-api.redfenix.ec/ads?user=BB:BB:BB:BB:BB:C0&site=dnsofsite.redfenix.ec&ip_local=127.0.0.1' \
  --header 'authorization: apiKeyGenerated'
```

> The above command returns JSON structured like this:

```json
{
    "typography": "roboto",
    "src": [
        "//assets.redfenix.ec/pautas/53/fondo_v.jpg",
        "//assets.redfenix.ec/pautas/53/fondo_h.jpg",
        "https://webstyle.unicomm.fsu.edu/img/placeholders/ratio-3-4.png",
        "https://designshack.net/wp-content/uploads/4-3.jpg"
    ],
    "name": "pauta1",
    "description": "esto es una pauta",
    "type": "image",
    "encoding": [
        "jpg"
    ],
    "colors": [
        "#FFFFFF",
        "#000000"
    ],
    "id": 6259,
    "siteName": "sitio",
    "siteLogo": "http://bitlabs.nl/svgmagic/images/results/www.wowdoge.org/logo-wowdoge.png"
}
```

Este endpoint devuelve todos los ads asociados a un sitio*.

### HTTP Request

`GET https://f-api.redfenix.ec/ads`

### Parámetros del query

Parámetro | default | Descripción | Requerido
--------- | ------- | ----------- | --------
user | None | identificación del dispositivo de usuario | Yes
site | None | dns del sitio al que me estoy conectando | Yes
ip_local | None | ip local del usuario | Yes
ad_id | None | identificación del Ad específico que se quiere buscar. No necesitas enviar los otros parámetros si éste campo está lleno. | No

<aside class="success">
Recuerda — tus requests deben estar autenticados para poder recibir la respuesta adecuada.
</aside>

## Borrar un Ad

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.delete(2)
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.delete(2)
```

```shell
curl "http://example.com/api/kittens/2"
  -X DELETE
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
let max = api.kittens.delete(2);
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "deleted" : ":("
}
```

This endpoint retrieves a specific kitten.

### HTTP Request

`DELETE http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the kitten to delete


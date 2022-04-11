# EMS

### Requirements

Known to be working on:

- MacOS Monterrey 12.2.1
- Xcode 13.2.1


## Mocks

I'm using SwiftyMocky. To regenerate mocks use: 
```
mint run SwiftyMocky generate
```


## Considerations

The code style I used is the one from PagoFX (with a little tweaking) since it's the one I'm used to work with.

Architecture used is MVVM with coordinators.

Since no API documentation is provided on weather the fields are mandatory or not so I assumed every attribute is mandatory.

Dark mode is disabled on purpose for this test.

Locked orientation to portrait only.


## Possible improvements

Use VO models if needed (or any other layer entities for that matter...)

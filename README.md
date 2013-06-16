CFIFrostedOverlayView
=====================

A view that renders its superview with a gaussian blur like iOS 7's Control Center

![Frosted Overlay Screenshot](https://raw.github.com/CodaFi/CFIFrostedOverlayView/master/Artwork/Screen%20Shot%202013-06-16%20at%201.50.35%20PM.png)

Caveats
=======

Because of the way that this control renders its superview, you must provide it an offset if you choose to not have the control take up the entirety of its superview, and guarantee that it is not onscreen when its superview is being rendered.  For example, the demo project shows how to offset the control by 20 pixels from the top of the screen.

```ObjC
  self.controlCenter = //...
	self.controlCenter.offset = 20.f;
	[self.view addSubview:self.controlCenter];
	self.controlCenter.viewToBlur = self.view;
```

The inset of the control's frame and its `contentOffset` must match exactly, else the rendered view will be mis-aligned with the actual view.

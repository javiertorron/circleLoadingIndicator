# circleLoadingIndicator
##Indicador de carga con forma circular para iOS - Objective C

###Implementación cabecera:
```objective-c
@property (nonatomic) CircleViewLoader *progressIndicatorView;
```

###Implementación clase:
####(La implementación puede realizarse en un IBAction o en un viewWillAppear)
```objective-c
- (void)viewDidLoad {
    _progressIndicatorView = [[CircleLoaderView alloc] initWithLayer:CGRectZero withColor:[UIColor redColor] withRadius:40.0];
}

-(void)yourMethodHere {
    self.progressIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.progressIndicatorView];
    // Le agregamos constrains al CircleLoaderView de forma que mantenga tamaño que tenía
    [self.progressIndicatorView addConstraint:[NSLayoutConstraint constraintWithItem:self.progressIndicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.loadingRadius]];
    [self.progressIndicatorView addConstraint:[NSLayoutConstraint constraintWithItem:self.progressIndicatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.loadingRadius]];
    // Agregamos constraints a la vista para centrarlo vertical y horizontalmente
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.progressIndicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.progressIndicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    // Lo volvemos a agregar a la vista para que coja los constraints
    [self.view addSubview:self.progressIndicatorView];
}

-(void) animateLoadingIndicator {
    self.elapsedTime += self.animationStepLength;
    if (self.elapsedTime >= self.maxAnimationTime) {
        // Cancelamos el timer y lo liberamos
        [self.animator invalidate];
        self.animator = nil;
        // Realizamos la transición a la ventana correcta
        self.progressIndicatorView.progress = 1;
        [self goToView];  // Implementamos aquí la transición a la Vista que queramos o bien cualquier otra acción que se quiera realizar cuando termine
    } else {
        // Actualizamos el progreso
        self.progressIndicatorView.progress = self.elapsedTime / self.maxAnimationTime;
    }
}
```

Nota: En este caso se ha utilizado la propia View para agregar el CircleLoaderView al centro de la vista, pero cambiando los constraints se puede agregar en cualquier lugar.

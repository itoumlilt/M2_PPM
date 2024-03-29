//
//  GameView.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "GameView.h"

@interface GameView () {
}

@end

@implementation GameView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        
        [self setHidden:YES];
        
        /* levelLabel */
        _levelLabel = [[UILabel alloc] init];
        [_levelLabel setText:@"Niveau: X"];
        [_levelLabel setTextAlignment:NSTextAlignmentLeft];
        [_levelLabel setTextColor:[UIColor whiteColor]];
        
        /* scoreLabel */
        _scoreLabel = [[UILabel alloc] init];
        [_scoreLabel setText:@"Score: 0"];
        [_scoreLabel setTextAlignment:NSTextAlignmentRight];
        [_scoreLabel setTextColor:[UIColor whiteColor]];
        
        /* leftButton */
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitle:@"<<<" forState:UIControlStateNormal];
        [_leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_leftButton.titleLabel setTextColor:[UIColor whiteColor]];
        
        /* rightButton */
        _rightButton = [[UIButton alloc] init];
        [_rightButton setTitle:@">>>" forState:UIControlStateNormal];
        [_rightButton.titleLabel setTextAlignment:NSTextAlignmentRight];
        [_rightButton.titleLabel setTextColor:[UIColor whiteColor]];
        
        /* gameContainer */
        _gameContainer = [[UIView alloc] init];
        
        [self drawSubviews:frame.size];
        
        /* DynamicAnimator */
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:_gameContainer];
        
        /* myMinionView */
        _myMinionView = [[MinionView alloc] initWithMovingArea:CGRectMake(0, _gameContainer. frame.size.height - 60, _gameContainer.frame.size.width, 50)];
        
        /* j'init mon timer pour les asteroids */
        [NSTimer scheduledTimerWithTimeInterval:0.7
                                         target:self
                                       selector:@selector(addNewAsteroid:)
                                       userInfo:nil
                                        repeats:YES];
        
        /* adding and releasing subviews */
        [self addSubview:_levelLabel]; [_levelLabel  release];
        [self addSubview:_scoreLabel]; [_scoreLabel  release];
        [self addSubview:_leftButton]; [_leftButton  release];
        [self addSubview:_rightButton];[_rightButton release];
        
        //gameContainer.backgroundColor = [UIColor whiteColor];
        
        [_gameContainer addSubview:_myMinionView];
        [_myMinionView release];
        
        /* Collision */
        _collision = [[UICollisionBehavior alloc] init];
        [_collision setCollisionMode:UICollisionBehaviorModeBoundaries];
        
        /* je veux définir le minion comme limite de collision poru intercepter les chocs */
        CGPoint rightEdge = CGPointMake(_myMinionView.frame.origin.x + _myMinionView.frame.size.width, _myMinionView.frame.origin.y);
        [_collision addBoundaryWithIdentifier:@"myMinionView"
                                    fromPoint:_myMinionView.frame.origin
                                      toPoint:rightEdge];
        
        /* limite pour release les asteroides */
        CGPoint leftEdge2 = CGPointMake(_gameContainer.frame.origin.x, _gameContainer.frame.origin.y + _gameContainer.frame.size.height + 50);
        CGPoint rightEdge2 = CGPointMake(_gameContainer.frame.origin.x + _gameContainer.frame.size.width, _gameContainer.frame.origin.y + _gameContainer.frame.size.height + 50);
        [_collision addBoundaryWithIdentifier:@"gravityLimit"
                                    fromPoint:leftEdge2
                                      toPoint:rightEdge2];
        
         
         [_animator addBehavior:_collision];
         
        /* gravité */
        _gravity = [[UIGravityBehavior alloc] init];
        [_animator addBehavior:_gravity];
        
        [self addSubview:_gameContainer];[_gameContainer release];
    }
    
    return self;
}

- (void)drawSubviews:(CGSize)frame
{
    const CGFloat V_BORDERLINE = 10;
    const CGFloat H_BORDERLINE = 20;
    
    self.frame = CGRectMake(0, 0, frame.width, frame.height);
    
    /* levelLabel */
    _levelLabel.frame = CGRectMake(V_BORDERLINE, H_BORDERLINE, 100, 20);
    
    /* scoreLabel */
    _scoreLabel.frame = CGRectMake(frame.width - V_BORDERLINE - 150, H_BORDERLINE, 150, 20);
    
    /* leftButton */
    _leftButton.frame = CGRectMake(V_BORDERLINE,
                                   frame.height - H_BORDERLINE - 30, 50, 30);
    
    /* rightButton */
    _rightButton.frame = CGRectMake(frame.width - V_BORDERLINE - 50,
                                    frame.height - H_BORDERLINE - 30,
                                    50, 30);
    
    /* setting gameContainer area */
    _gameContainer.frame = CGRectMake(V_BORDERLINE + _leftButton.frame.size.width,
                               0,
                               frame.width - (2*V_BORDERLINE + _leftButton.frame.size.width +
                                              _rightButton.frame.size.width),
                               frame.height);
}

- (void)addNewAsteroid:(NSTimer*)timer
{
    const CGFloat asterSize = 30;
    if( _gameContainer ) {
        AsteroidView* myAster = [[AsteroidView alloc] initWithFrame:CGRectMake((arc4random()%(int)(_gameContainer.frame.size.width - asterSize)), -asterSize, asterSize, asterSize)];
    
        [_gameContainer addSubview:myAster];
    
        [_gravity addItem:myAster];
        [_collision addItem:myAster];
        
        [myAster release];
    } else {
        [timer invalidate];
    }
}

- (void)removeAsteroid:(AsteroidView*)aster
{
    [_gravity removeItem:aster];
    [_collision removeItem:aster];
    [aster killMe];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

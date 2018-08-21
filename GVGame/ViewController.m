//
//  ViewController.m
//  GVGame
//
//  Created by Gohar Vardanyan on 2/25/18.
//  Copyright © 2018 Gohar Vardanyan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray <UIImageView *> *matching;
@property (assign, nonatomic) NSInteger counter;
@property (assign, nonatomic) NSInteger tagNum;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    self.matching = array;
    
    UIImage *image = [UIImage imageNamed:@"bgrImage"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:imageView];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    //gv
    [self startGame];
}

//amen angam xax@ skselis kanchvum e ays funkcian/// nayev alertic heto ete sexmum en PLAY AGAIN:
- (void)startGame {
    self.tagNum = 0;
    UIView * basicView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 186 / 2,self.view.bounds.size.height / 2 - 246 / 2 , 185, 246)];
    [self.view addSubview:basicView];
    basicView.tag = 1;
    
    basicView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    basicView.layer.borderWidth = 2;
    [basicView.layer setBorderColor:[UIColor colorWithRed:0.3 green:0.5 blue:0.3 alpha:1].CGColor];
    
    //for-ov sarqeum enq 12 hat UIImage, voronq der image chunen:
    NSInteger locationY = 0;
    for (int i = 0; i < 4; i++) {
        NSInteger locationX = 0;
        for (int j = 0; j < 3; j++) {
            UIImageView *colorViews = [[UIImageView alloc] initWithFrame:CGRectMake(locationX, locationY, 60, 60)];
            [basicView addSubview:colorViews];
            colorViews.userInteractionEnabled = YES;
            locationX += 62;
        }
        locationY += 62;
    }
    
    //erku kammayakan kubiki talis enq mek nkar hamapatasxan metodov
    [self chooseImage:basicView.subviews];
    
    //ays for-ov animaciayov cackum enq bolor nkarner@ mek guyni view-ov
    for (UIView *imageView in basicView.subviews) {
        
        UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        greenView.backgroundColor = [UIColor greenColor];
        greenView.alpha = 0;
        
        [imageView addSubview:greenView];
        [self animation:greenView];
    }
}

//tramadrum enq jamanaak, vorpeszi User@ mtapahi nkarneri dirqer@, ev aynuhetev pahum enq guyner@`animaciayov u dnum enq tap, vorpeszi kpneluc bacvi taki nkar@:
-(void)animation:(UIView *)view {
    [UIView animateWithDuration:2
                          delay:5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.alpha = 1;
                     } completion:^(BOOL finished) {
                         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
                         [view addGestureRecognizer:tap];
                     }];
}

//Tap-i jamanak stugum enq ete 2 taper@ nuynn en, apa dnum e ptichka`animaciayov, ete voch, apa noric cackum e guyn@`animaciayov
- (void)handleTap:(UITapGestureRecognizer *)gesture {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        gesture.view.alpha = 0;
        for (UIImageView *imgView in [self.view viewWithTag:1].subviews) {
            imgView.userInteractionEnabled = NO;// anjatum e Tap-@ vorpeszi 2-i nmanutyun@ stugelu jamanak ayl view-er chbacven
        }
    } completion:^(BOOL finished) {
        [self.matching addObject:(UIImageView*)gesture.view.superview];
        
        if (self.matching.count == 1) {
            for (UIImageView *imgView in [self.view viewWithTag:1].subviews) {
                imgView.userInteractionEnabled = YES;// miacnum e Tap@, qani vor der mek view e bacvac
            }
            gesture.view.tag = 10 + self.tagNum;
        }
        
        if (self.matching.count == 2) {
            if ([self.matching[0].image isEqual:self.matching[1].image]) {
                UIImage *img1 = [UIImage imageNamed:@"Done"];
                
                UIImageView *done1 = [[UIImageView alloc] initWithImage:img1];//animaciayov ptichka nkarn e dnum
                done1.frame = CGRectMake(0, 0, 60, 60);
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:2];
                [UIView setAnimationDelay:0.4];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.matching[0] cache:YES];
                [self.matching[0] addSubview:done1];
                [UIView commitAnimations];
                
                UIImageView *done2 = [[UIImageView alloc] initWithImage:img1];//animaciayov ptichka nkarn e dnum
                done2.frame = CGRectMake(0, 0, 60, 60);
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:2];
                [UIView setAnimationDelay:0.3];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.matching[1] cache:YES];
                [self.matching[1] addSubview:done2];
                [UIView commitAnimations];
                
                self.counter += 2;
                self.tagNum ++;
                [self.matching removeAllObjects];
                for (UIImageView *imgView in [self.view viewWithTag:1].subviews) {
                    imgView.userInteractionEnabled = YES;// miacnum e Tap-, qani vor erku view irar nman en
                }
                if (self.counter == 12) { //ete bolor nkarner@ arden gushakvac en kanchum e allert
                    [self allert];
                }
            } else {
                [UIView animateWithDuration:2 animations:^{
                    [[self.view viewWithTag:10+self.tagNum] setAlpha:1];
                    [gesture.view setAlpha:1];
                    [self.matching removeAllObjects];
                    self.tagNum ++;
                } completion:^(BOOL finished) {
                    for (UIImageView *imgView in [self.view viewWithTag:1].subviews) {
                        imgView.userInteractionEnabled = YES;// miacnum e Tap-@, qani vor erku view irar tarber en
                    }
                }];
            }
        }
    }];
}
//2 kamajakan UIImageView-eri talis enq kamayakan mek Image

- (void)chooseImage:(NSArray <UIImageView *> *)subviews {
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    for ( int i = 1; i <= 6; i++) {
        NSString *imgName = [NSString stringWithFormat:@"Bird%d", i ];
        UIImage *image = [UIImage imageNamed:imgName];
        [images addObject:image];
    }
    
    NSMutableArray *viewNumArray = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12] mutableCopy];
    NSMutableArray *imgNumArray = [@[@1, @2, @3, @4, @5, @6] mutableCopy];
    
    while (imgNumArray.count != 0) {
        NSInteger imgNum = arc4random() % 6 + 1;
        
        if ([imgNumArray containsObject:@(imgNum)]) {
            NSInteger counter = 0;
            
            while (counter != 2) {
                NSInteger viewNum =arc4random() % 12 + 1;
                
                if([viewNumArray containsObject:@(viewNum)]) {
                    subviews[viewNum - 1].image = images[imgNum - 1];
                    [viewNumArray removeObject:@(viewNum)];
                    counter ++;
                }
            }
            [imgNumArray removeObject:@(imgNum)];
        }
    }
}

- (void)allert {
    UIAlertController *allert = [UIAlertController alertControllerWithTitle:@"!!YOU WON!!" message:@"Do you want to continue?" preferredStyle:UIAlertControllerStyleAlert];
    
    //xax@ sksvum e noric
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"Play again"
                                                    style:(UIAlertActionStyleDefault)
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      self.counter = 0;//amen inch 0 acnum enq allert-ic heto noric xax@ skselu hamar
                                                      for (UIView *subview in self.view.subviews) {
                                                          if (subview.tag == 1) {
                                                              [subview removeFromSuperview];
                                                          }
                                                      }
                                                      [self startGame];
                                                  }];
    
    //xax@ dadarum e ev gnum e ayl view-i vra, vortexic noric karox enq sksel xax@
    UIAlertAction *stop = [UIAlertAction actionWithTitle:@"Quit"
                                                   style:UIAlertActionStyleCancel
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                     
                                                     UIImageView *wonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Won"]];
                                                     [self.view addSubview:wonImage];
                                                     wonImage.userInteractionEnabled = YES;
                                                     wonImage.tag = 2;
                                                     
                                                     UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x - 100 / 2, self.view.center.y - 50 / 2, 100, 50)];
                                                     [wonImage addSubview:button];
                                                     [button setTitle:@"GO BACK" forState:UIControlStateNormal];
                                                     [button setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
                                                     [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
                                                     button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
                                                 }];
    
    [allert addAction:again];
    [allert addAction:stop];
    [self presentViewController:allert animated:YES completion:nil];
}

- (void)handleButton:(UIButton *)button{
    self.counter = 0;//amen inch 0 acnum enq allert-ic heto noric xax@ skselu hamar
    for (UIView *subview in self.view.subviews) {
        if (subview.tag == 1 | subview.tag == 2) {
            [subview removeFromSuperview];
        }
    }
    [self startGame];
}
@end

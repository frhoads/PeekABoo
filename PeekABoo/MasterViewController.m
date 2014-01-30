//
//  ViewController.m
//  PeekABoo
//
//  Created by Apple on 30/01/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Go to new view Controller with fullscreen image;
}

@end

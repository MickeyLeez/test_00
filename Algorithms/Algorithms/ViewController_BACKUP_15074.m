//
//  ViewController.m
//  Algorithms
//
//  Created by Frank on 2017/8/1.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "ViewController.h"
#import "sortAlgorithms.h"


@interface ViewController ()

@end

@implementation ViewController

- (NSMutableArray*)createMultiArr{
    
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObjectsFromArray:@[@5,@3,@7,@2,@1,@5,@2]];
//     [arr addObjectsFromArray:@[@5,@9,@8,@9]];
    return arr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

//    NSMutableArray *multiArr = [self createMultiArr];
    
    
//    NSMutableArray *arr = [sortAlgorithms bubbleSortWith:[self createMultiArr]];
// 
//    
//    NSMutableArray *arr1 = [sortAlgorithms selectionSortWith:[self createMultiArr]];
//
//    
//    NSMutableArray *arr2 = [sortAlgorithms insertionSortWith:[self createMultiArr]];
//    
//    NSMutableArray *arr3 = [sortAlgorithms binaryInsertionSortWith:[self createMultiArr]];
    
//    NSMutableArray *arr4 = [[sortAlgorithms shareInstance] shellSortWith:[self createMultiArr]];
    
//    [[sortAlgorithms shareInstance] mergeSortWith:multiArr lowIndex:0 andHighIndex:multiArr.count-1];
    
//    [[sortAlgorithms shareInstance] quickSortArray:multiArr leftIndex:0 andRightIndex:multiArr.count - 1];
//
//   NSInteger deptah = [BinaryTreeNode depthOfTree:[BinaryTreeNode CreateABinaryTree]];
//    
//    NSLog(@"*****%zd",deptah);
    
 

}


-(void)test{
    
    NSLog(@"12344646");
}

-(void)test_1{
    
    NSLog(@"12344646");
}

<<<<<<< HEAD
-(void)test_2{
=======
-(void)test_4{
>>>>>>> master_0
    
    NSLog(@"12344646");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

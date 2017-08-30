//
//  sortAlgorithms.h
//  Algorithms
//
//  Created by Frank on 2017/8/1.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface sortAlgorithms : NSObject


#pragma -常见的排序算法

+ (sortAlgorithms*)shareInstance;

- (NSMutableArray*)bubbleSortWith:(NSMutableArray*)array;

- (NSMutableArray*)selectionSortWith:(NSMutableArray*)array;

- (NSMutableArray*)insertionSortWith:(NSMutableArray*)array;

- (NSMutableArray*)binaryInsertionSortWith:(NSMutableArray*)array;

- (NSMutableArray*)shellSortWith:(NSMutableArray*)array;

- (void)heapSortWith:(NSMutableArray*)array;

- (void)mergeSortWith:(NSMutableArray*)array lowIndex:(NSInteger)lowIndex andHighIndex:(NSInteger)highIndex;

- (void)quickSortArray:(NSMutableArray*)array leftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex;


#pragma -常见的查找算法

- (NSInteger)binarySearchArray:(NSMutableArray*)array withKey:(NSInteger)key;

- (NSInteger)interpolationSearchArray:(NSMutableArray*)array withKey:(NSInteger)key;

- (NSInteger)fibonacciSearchArray:(NSMutableArray*)array withKey:(NSInteger)key;


@end



@interface BinaryTreeNode : NSObject{//定义一个二叉树节点私有类
    id data;
    BinaryTreeNode *left;
    BinaryTreeNode *right;
}
+ (BinaryTreeNode *)addTree:(BinaryTreeNode *)p andValue:(id)value;//构建二叉树的方法

+ (BinaryTreeNode*)CreateABinaryTree;

+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode;

@end;

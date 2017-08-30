//
//  sortAlgorithms.m
//  Algorithms
//
//  Created by Frank on 2017/8/1.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "sortAlgorithms.h"

static sortAlgorithms *sortManerger;

@interface sortAlgorithms()

@property (nonatomic, strong)NSMutableArray *tempArr;

@end

@implementation sortAlgorithms

-(NSMutableArray*)tempArr{
    
    if (!_tempArr) {
        _tempArr = [NSMutableArray new];
    }
    return _tempArr;
}

+(sortAlgorithms*)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sortManerger = [[sortAlgorithms alloc] init];
    });
    return sortManerger;
}



- (NSMutableArray*)bubbleSortWith:(NSMutableArray *)array{
    
    for (int i = 0; i < array.count - 1; i++) {
        
        for (int j = 0; j < array.count - i - 1; j++) {//总是交换相邻的两个元素，一次循环后最大的元素排在右边
            
            if (array[j] > array[j + 1]) {
                
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    return array;
}

- (NSMutableArray*)selectionSortWith:(NSMutableArray*)array{
    
    
    for (int i = 0; i < array.count - 1; i++) {
        
        int minIndex = i;
        for (int j = i + 1; j < array.count ; j++) {//每次都选择出相对最小的元素一次排在左边
            
            if (array[j] < array[i]) {
                
                minIndex = j;
            }
        }
        if (minIndex != i) {
            NSNumber *temp = array[i];
            array[i] = array[minIndex];
            array[minIndex] = temp;
        }
    }

    
    return array;
}

- (NSMutableArray*)insertionSortWith:(NSMutableArray*)array{//直接插入排序
    
    for (int i = 1; i < array.count; i++) {
        
        if (array[i] < array [i - 1]) {
        
            int temp = [array[i] intValue];
            int j = i - 1;
            for (; j >= 0 && [array[j] intValue] > temp ; j--) {
                
                array[j + 1] = array[j]; //数组元素后移一位
            }
            array[j + 1] = [NSNumber numberWithInt:temp];
        }
    }
   
    
    return array;
}

- (NSMutableArray*)binaryInsertionSortWith:(NSMutableArray*)array{//折半插入排序
    
    for (int i = 1; i < array.count; i++) {
        
        int left = 0;
        int right = i - 1;
        int temp = [array[i] intValue];
        
        while (left <= right) {
            
            int mid = (left + right)/2;
            
//            if (temp < [array [mid] intValue]) {
//                
//                
//                right = mid - 1;
//                
//            }
//            else{
//                
//                left = mid + 1;
//            }
//            
            temp < [array [mid] intValue] ? (right = mid - 1) : (left = mid + 1);
            
        }//至此二分查找结束,left就是元素应该插入的位置
        
        for ( int j = i; j > left; j--) {
            
            [array exchangeObjectAtIndex:j withObjectAtIndex:j - 1];
            
        }
        
        array[left] = [NSNumber numberWithInt:temp];
    }
    
    return array;
}


- (NSMutableArray*)shellSortWith:(NSMutableArray*)array{//类似于直接插入排序
    
    int increment = (int)array.count;
    
    while (increment > 1) {
        
        increment = increment / 2;
        
        for (int i = increment ; i < array.count; i++) {
            
            if ([array[i - increment] intValue] > [array[i] intValue] ) {
                
                int temp = [array[i] intValue];
                int j = i - increment;
                
                for (; j >= 0 && [array[j] intValue] > temp; j-=increment ) {//实现了元素可以跨过多个元素移动，可能减少移动次数
                    
                    array[j+increment] = array[j];
                }
                
                array[j+increment] = [NSNumber numberWithInt:temp];
            }
        }
    }
    
    return array;
}



- (void)heapSortWith:(NSMutableArray*)array{//堆排序
    
      NSInteger n = array.count;
    
    //step1：序列构建成大根堆
    for(NSInteger i = (n-1)/2 ;i >= 0; i--){
        //即对每个节点和其子节点的大根堆构造
        [self heapAdjust:array index:i andLength:n];
    }
    
    
    for(NSInteger i = n-1 ;i >0; i--){
        NSNumber *temp = array[i];
        array[i] = array[0];
        array[0] = temp;
        //step3：重构
        [self heapAdjust:array index:0 andLength:i];
    }
}

- (void)heapAdjust:(NSMutableArray*)array index:(NSInteger)node andLength:(NSInteger)length{//
    
    if ((node*2 +1) <= length - 1) {// 保证该节点为非叶子节点，因为叶子节点就没意义了
        
        NSInteger child = node * 2 + 1;//字节点坐标，主要是交换完后需要以该child为节点判断以及调整大根堆
        if (child + 1 <= length-1) {//如果有有右子树
            if (array[child + 1] > array[child]) {
                child++;//判断后如果右子树大于左子树，child++，即等会要操作的是左子树节点
            }
        }
        
        if(array[node]< array[child]){//大的子树与node比较
            //交换
            NSNumber *temp = array[node];
            array[node] = array[child];
            array[child] = temp;
            //再次重构
            [self heapAdjust:array index:child andLength:length];
        }
    }
}



- (void)mergeSortWith:(NSMutableArray*)array lowIndex:(NSInteger)lowIndex andHighIndex:(NSInteger)highIndex{//归并排序
    
    if (lowIndex >= highIndex) {
        return;
    }
    NSInteger midIndex = lowIndex + (highIndex - lowIndex) / 2;
    
    [self mergeSortWith:array lowIndex:lowIndex andHighIndex:midIndex];
    [self mergeSortWith:array lowIndex:midIndex + 1 andHighIndex:highIndex];
    [self mergerArray:array lowIndex:lowIndex midIndex:midIndex andHighIndex:highIndex];
}


-(void)mergerArray:(NSMutableArray*)array lowIndex:(NSInteger)lowIndex midIndex:(NSInteger)midIndex andHighIndex:(NSInteger)highIndex{
    
    for (NSInteger i = lowIndex; i <= highIndex ; i++) {
        
        self.tempArr[i] = array[i];
    }
    
    NSInteger k = lowIndex;
    NSInteger l = midIndex + 1;
//     NSLog(@"%zd=%zd=%zd=%zd",lowIndex,midIndex,l,highIndex);
    for (NSInteger j = lowIndex; j <= highIndex; j++) {
        
        if (l > highIndex) {//表明右边的数组已经比较完
            
            array[j] = self.tempArr[k++];
            
        }else if (k > midIndex){//表明左边的数组已经比较完
            
            array[j] = self.tempArr[l++];
            
        }else if ([self.tempArr[k] integerValue] > [self.tempArr[l] integerValue]){//两个待归并数组依次向后比较
            
            array[j] = self.tempArr[l++];
            
        }else{
            
            array[j] = self.tempArr[k++];
        }
    }
}


- (void)quickSortArray:(NSMutableArray*)array leftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex{//快速排序
    
    if (leftIndex >= rightIndex) {//数组为空或者只有一个元素
        return;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
   
    while (i < j) {
   
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array leftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array leftIndex:i + 1 andRightIndex:rightIndex];
}

-(NSMutableArray*)mergeFirArr:(NSArray*)firstArr secArr:(NSArray*)secArr{
    
    NSMutableArray *mergeArr = [NSMutableArray new];
    
    int i ,j, k;
    i = j = k = 0;
    
    while (i < firstArr.count && j < secArr.count) {
        
        
        if (firstArr[i] <= secArr[j]) {
            
            mergeArr[k++] = firstArr[i++];
            
        }else{
            
            mergeArr[k++] = secArr[j++];
        }
    }
    
    while (i < firstArr.count) {
        
          mergeArr[k++] = firstArr[i++];
    }
    
    while (j < secArr.count) {
       
        mergeArr[k++] = secArr[k++];
    }
    
    return mergeArr;
}


#pragma -常见的查找算法

- (NSInteger)binarySearchArray:(NSMutableArray*)array withKey:(NSInteger)key{
    
    NSInteger  left = 0;
    NSInteger right = array.count - 1;
    NSInteger mid = (left + right)/2;
    
    while (left <= right) {
        
        if (key == [array[mid] integerValue]) {
            
            return mid;
        }else if(key > [array[mid] integerValue]){
            
            left = mid + 1;
            
        }else{
            
            right = mid - 1;
        }
    }
    return -1;
    
    
//    //二分查找，递归版本
//    int BinarySearch2(int a[], int value, int low, int high)
//    {
//        int mid = low+(high-low)/2;
//        if(a[mid]==value)
//            return mid;
//        if(a[mid]>value)
//            return BinarySearch2(a, value, low, mid-1);
//        if(a[mid]<value)
//            return BinarySearch2(a, value, mid+1, high);
//    }
}


- (NSInteger)interpolationSearchArray:(NSMutableArray*)array withKey:(NSInteger)key{//插值查找
    
    NSInteger left = 0;
    NSInteger right = array.count - 1;
    NSInteger mid = left + (key - [array[left] integerValue])/([array[right] integerValue] - [array[left] integerValue])*(right - left);
    
    if (key == [array[mid] integerValue]) {
        
        return mid;
    }else if(key > [array[mid] integerValue]){
        
        left = mid + 1;
        
    }else{
        
        right = mid - 1;
    }
    
    return -1;
}

- (NSInteger)fibonacciSearchArray:(NSMutableArray*)array withKey:(NSInteger)key{//斐波那契查找
    
    /*构造一个斐波那契数组*/
//    void Fibonacci(int * F)
//    {
//        F[0]=0;
//        F[1]=1;
//        for(int i=2;i<max_size;++i)
//            F[i]=F[i-1]+F[i-2];
//    }
    
    //这里假设array已经是斐波那契数组
    
    NSInteger low = 0;
    NSInteger high = array.count - 1;
    
    NSInteger k = 0;//获斐波那契分割数组的下标
    while (high + 1 > ([array[k] integerValue] - 1) ) {
        
        k++;
    }
    
//    [array ] .....
    

    
    return -1;
}

@end



#pragma -二叉树相关算法
//@interface BinaryTreeNode : NSObject{//定义一个二叉树节点私有类
//    id data;
//    BinaryTreeNode *left;
//    BinaryTreeNode *right;
//}
//
//+ (BinaryTreeNode *)addTree:(BinaryTreeNode *)p andValue:(id)value;//构建二叉树的方法
//
//@end;

//@interface  TreeNodeProperty : NSObject
//
//@property (nonatomic, assign) NSInteger distance;
//
//@property (nonatomic, assign) NSInteger depth;
//
//@end


@implementation BinaryTreeNode

+ (BinaryTreeNode *)addTree:(BinaryTreeNode *)p andValue:(id)value{//
    if (nil == p) {
        p = [[BinaryTreeNode alloc] init];
        p->data = value;
        p->left = p->right = nil;
    }
    else if(! ([value intValue] < [p->data intValue]) )
        p->left = [BinaryTreeNode addTree:p->left andValue:value];
    else
        p->right = [BinaryTreeNode addTree:p->right andValue:value];
    return p;
}

+ (BinaryTreeNode*)CreateABinaryTree{//创建二叉排序树
    
    BinaryTreeNode *root = nil;
    
    for (id value in @[@(2),@(5),@(6),@(8),@(9)]) {
        root = [BinaryTreeNode addTree:root andValue:value];
    }
    
    return root;
}


+(void)preorderTraversalWtihNodes:(BinaryTreeNode*)p andResultArr:(NSMutableArray*)resultArr{//二叉树前序遍历
    
    if (p != nil) {//首次传入的p为根节点
        
        [resultArr addObject:p->data];
        [self preorderTraversalWtihNodes:p->left andResultArr:resultArr];
        [self preorderTraversalWtihNodes:p->right andResultArr:resultArr];
    }
}


/*****************二叉树遍历的递归写法******************/

+ (void)inorderTraversalWtihNodes:(BinaryTreeNode*)p andResultArr:(NSMutableArray*)resultArr{//二叉树中序遍历
    
    if (p != nil) {//首次传入的p为根节点
        
        [self preorderTraversalWtihNodes:p->left andResultArr:resultArr];
        [resultArr addObject:p->data];
        [self preorderTraversalWtihNodes:p->right andResultArr:resultArr];
    }
}

+ (void)postorderTraversalWtihNodes:(BinaryTreeNode*)p andResultArr:(NSMutableArray*)resultArr{//二叉树后序遍历
    
    if (p != nil) {//首次传入的p为根节点
        
        [self preorderTraversalWtihNodes:p->left andResultArr:resultArr];
        [self preorderTraversalWtihNodes:p->right andResultArr:resultArr];
        [resultArr addObject:p->data];
    }
    
}

+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {//层序遍历
    if (!rootNode) {
        return;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列 ???同理非递归遍历中也可以用数组充当栈？？？
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        
        BinaryTreeNode *node = [queueArray firstObject];
        
        if (handler) {
            handler(node);
        }
        
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        if (node->left) {
            [queueArray addObject:node->left]; //压入左节点
        }
        if (node->right) {
            [queueArray addObject:node->right]; //压入右节点
        }
    }
}

/*************************             查找某个位置的节点
 
 *类似索引操作，按层次遍历，位置从0开始算。
 
 *  二叉树中某个位置的节点（按层次遍历）
 *
 *  @param index    按层次遍历树时的位置(从0开始算)
 *  @param rootNode 树根节点
 *
 *  @return 节点
 */

+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode {
    
    if (!rootNode || index < 0) {
        
        return nil;
    }
    
    NSMutableArray *queueArr = [NSMutableArray array];//可变数组模拟队列
    [queueArr addObject:rootNode];
    
    while (queueArr.count > 0) {
        
        BinaryTreeNode *node = [queueArr firstObject];
        
        if (index == 0) {
            
            return node;
        }
        
        [queueArr removeObjectAtIndex:0];
        index--;
        
        if (node->left) {
            [queueArr addObject:node->left];
        }
        if (node->right) {
            [queueArr addObject:node->right];
        }
    
    }
    
    return nil;
}



/*****************二叉树遍历的非递归写法******************/

/*

 参考链接：http://www.jianshu.com/p/49c8cfd07410
 
*/

/**************已知前序（后序）、中序，求后序（前序）**************************/

/*
 
 参考链接： https://yq.aliyun.com/articles/31109
 
 */

/*****************求二叉树的深度******************/

/**   二叉树的深度定义为：从根节点到叶子结点依次经过的结点形成树的一条路径,最长路径的长度为树的深度。
 
 *  如果根节点为空，则深度为0
 *  如果左右节点都是空，则深度为1；
 *  递归思想：二叉树的深度=max（左子树的深度，右子树的深度）+ 1

 */

+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode->left && !rootNode->right) {
        return 1;
    }

    //左子树深度
    NSInteger leftDepth = [self depthOfTree:rootNode->left];
    //右子树深度
    NSInteger rightDepth = [self depthOfTree:rootNode->right];
    
    return MAX(leftDepth, rightDepth) + 1;
}

/*****************求二叉树的宽度******************/

/**     二叉树的宽度定义为各层节点数的最大值。
 
 *  二叉树的宽度
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树宽度
 */

+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    NSInteger maxWidth = 1; //最大的宽度，初始化为1（因为已经有根节点）
    NSInteger curWidth = 0; //当前层的宽度
    
    while (queueArray.count > 0) {
        
        curWidth = queueArray.count;
        
        for (int i = 0; i < curWidth; i++) {//每次循环把上一层节点的依次删除，并计算他们的总共节点数
            
            BinaryTreeNode *node = [queueArray firstObject];
            [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
            
            //压入子节点
            if (node->left)
                [queueArray addObject:node->left];
            if (node->right)
                [queueArray addObject:node->right];
        }
        
        maxWidth = MAX(maxWidth, queueArray.count);
    }
    
    return maxWidth;
}

/*****************求二叉树的所有节点数******************/

/** 递归思想：二叉树所有节点数=左子树节点数+右子树节点数+1
 
 *  二叉树的所有节点数
 *
 *  @param rootNode 根节点
 *
 *  @return 所有节点数
 */

+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //节点数=左子树节点数+右子树节点数+1（根节点）
    return [self numberOfNodesInTree:rootNode->left] + [self numberOfNodesInTree:rootNode->right] + 1;
}

/*****************二叉树某层中的节点数******************/

/**
 *  根节点为空，则节点数为0；
 *  层为1，则节点数为1（即根节点）
 *  递归思想：二叉树第k层节点数=左子树第k-1层节点数+右子树第k-1层节点数
 
 *  二叉树某层中的节点数
 *
 *  @param level    层
 *  @param rootNode 根节点
 *
 *  @return 层中的节点数
 */

+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || level < 0) { //根节点不存在或者level<0
        return 0;
    }
    if (level == 1) { //level=1，返回1（根节点）
        return 1;
    }
    //递归：level层节点数 = 左子树level-1层节点数+右子树level-1层节点数
    return [self numberOfNodesOnLevel:level-1 inTree:rootNode->left] + [self numberOfNodesOnLevel:level-1 inTree:rootNode->right];
}

/*****************二叉树的叶子节点数******************/

/**
 *  二叉树叶子节点数
 *
 *  @param rootNode 根节点
 *
 *  @return 叶子节点数
 */

+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //左子树和右子树都是空，说明是叶子节点
    if (!rootNode->left && !rootNode->right) {
        return 1;
    }
    //递归：叶子数 = 左子树叶子数 + 右子树叶子数
    return [self numberOfLeafsInTree:rootNode->left] + [self numberOfLeafsInTree:rootNode->right];
}

/*****************二叉树最大距离（二叉树的直径）******************/

//  二叉树中任意两个节点都有且仅有一条路径，这个路径的长度叫这两个节点的距离。二叉树中所有节点之间的距离的最大值就是二叉树的直径。

/**
 *  二叉树最大距离（直径）
 *
 *  @param rootNode 根节点
 *
 *  @return 最大距离
 */

+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //    方案一：（递归次数较多，效率较低）
    //分3种情况：
    //1、最远距离经过根节点：距离 = 左子树深度 + 右子树深度
    NSInteger distance = [self depthOfTree:rootNode->left] + [self depthOfTree:rootNode->right];
    //2、最远距离在根节点左子树上，即计算左子树最远距离
    NSInteger disLeft = [self maxDistanceOfTree:rootNode->left];
    //3、最远距离在根节点右子树上，即计算右子树最远距离
    NSInteger disRight = [self maxDistanceOfTree:rootNode->right];
    
    return MAX(MAX(disLeft, disRight), distance);
}

 
//  方案一效率较低，因为计算子树的深度和最远距离是分开递归的，存在重复递归遍历的情况。其实一次递归，就可以分别计算出深度和最远距离，于是有了第二种方案：具体参见类TreeNodeProperty

//+ (NSInteger)maxDistance_2_OfTree:(BinaryTreeNode *)rootNode {
//    if (!rootNode) {
//        return 0;
//    }
//    //    方案2：将计算节点深度和最大距离放到一次递归中计算，方案一是分别单独递归计算深度和最远距离
//    TreeNodeProperty *p = [self propertyOfTreeNode:rootNode];
//    return p.distance;
//}

/**
 *  计算树节点的最大深度和最大距离
 *
 *  @param rootNode 根节点
 *
 *  @return TreeNodeProperty
 */

//+ (TreeNodeProperty *)propertyOfTreeNode:(BinaryTreeNode *)rootNode {
//    
//    if (!rootNode) {
//        return nil;
//    }
//    
//    TreeNodeProperty *left = [self propertyOfTreeNode:rootNode->left];
//    TreeNodeProperty *right = [self propertyOfTreeNode:rootNode->right];
//    TreeNodeProperty *p = [TreeNodeProperty new];
//    //节点的深度depth = 左子树深度、右子树深度中最大值+1（+1是因为根节点占了1个depth）
//    p.depth = MAX(left.depth, right.depth) + 1;
//    //最远距离 = 左子树最远距离、右子树最远距离和横跨左右子树最远距离中最大值
//    p.distance = MAX(MAX(left.distance, right.distance), left.depth+right.depth);
//    
//    return p;
//}

/*****************二叉树中某个节点到根节点的路径******************/

/*
 
 既是寻路问题，又是查找节点问题。
 
 定义一个存放路径的栈（不是队列了，但是还是用可变数组来实现的）
 
 1）压入根节点，再从左子树中查找（递归进行的），如果未找到，再从右子树中查找，如果也未找到，则弹出根节点，再遍历栈中上一个节点。
 
 2）如果找到，则栈中存放的节点就是路径所经过的节点。
 
 */

/**
 *  二叉树中某个节点到根节点的路径
 *
 *  @param treeNode 节点
 *  @param rootNode 根节点
 *
 *  @return 存放路径节点的数组
 */

+ (NSArray *)pathOfTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode {
    NSMutableArray *pathArray = [NSMutableArray array];
    [self isFoundTreeNode:treeNode inTree:rootNode routePath:pathArray];
    return pathArray;
}

+ (BOOL)isFoundTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode routePath:(NSMutableArray *)path {
    
    if (!rootNode || !treeNode) {
        return NO;
    }
    
    //找到节点
    if (rootNode == treeNode) {
        [path addObject:rootNode];
        return YES;
    }
    //压入根节点，进行递归
    [path addObject:rootNode];
    //先从左子树中查找
    BOOL find = [self isFoundTreeNode:treeNode inTree:rootNode->left routePath:path];
    //未找到，再从右子树查找
    if (!find) {
        find = [self isFoundTreeNode:treeNode inTree:rootNode->right routePath:path];
    }
    //如果2边都没查找到，则弹出此根节点
    if (!find) {
        [path removeLastObject];
    }
    
    return find;
}

/*****************二叉树中两个节点之间的路径(同时可以衍生为查找公共父节点)******************/

/**
 *  二叉树中两个节点之间的路径
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 两个节点间的路径
 */


+ (NSArray *)pathFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    NSMutableArray *path = [NSMutableArray array];
    if (nodeA == nodeB) {
        [path addObject:nodeA];
        [path addObject:nodeB];
        return path;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    //其中一个节点不在树中，则没有路径
    if (pathA.count == 0 || pathB == 0) {
        return nil;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count-1; i>=0; i--) {
        [path addObject:[pathA objectAtIndex:i]];
        for (NSInteger j = pathB.count - 1; j>=0; j--) {
            //找到公共父节点，则将pathB中后面的节点压入path
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                j++; //j++是为了避开公共父节点
                while (j<pathB.count) {
                    [path addObject:[pathB objectAtIndex:j]];
                    j++;
                }
                
                return path;
            }
        }
    }
    return nil;
}


/*****************二叉树中两个节点之间的距离******************/

/**
 *  二叉树两个节点之间的距离
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 两个节点间的距离（-1：表示没有找到路径）
 */

+ (NSInteger)distanceFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return -1;
    }
    if (nodeA == nodeB) {
        return 0;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    //其中一个节点不在树中，则没有路径
    if (pathA.count == 0 || pathB == 0) {
        return -1;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count-1; i>=0; i--) {
        for (NSInteger j = pathB.count - 1; j>=0; j--) {
            //找到公共父节点
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                //距离=路径节点数-1 （这里要-2，因为公共父节点重复了一次）
                return (pathA.count - i) + (pathB.count - j) - 2;
            }
        }
    }
    return -1;
}


/*****************翻转二叉树******************/

/**
 *  翻转二叉树（又叫：二叉树的镜像）
 *
 *  @param rootNode 根节点
 *
 *  @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */

+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return nil;
    }
    if (!rootNode->left && !rootNode->right) {
        return rootNode;
    }
    
    [self invertBinaryTree:rootNode->left];
    [self invertBinaryTree:rootNode->right];
    
    BinaryTreeNode *tempNode = rootNode->left;
    rootNode->left = rootNode->right;
    rootNode->right = tempNode;
    
    return rootNode;
}


/*****************判断二叉树是否完全二叉树******************/



/*
 
 
 完全二叉树定义为：若设二叉树的高度为h，除第h层外，其它各层的结点数都达到最大个数，第h层有叶子结点，并且叶子结点都是从左到右依次排布。
 
 完全二叉树必须满足2个条件：
 
 1）如果某个节点的右子树不为空，则它的左子树必须不为空
 
 2）如果某个节点的右子树为空，则排在它后面的节点必须没有孩子节点
 
 这里还需要理解“排在它后面的节点”，回头看看层次遍历算法，我们就能知道在层次遍历时，是从上到下从左到右遍历的，先将根节点弹出队列，再压入孩子节点，因此“排在它后面的节点”有2种情况：
 
 1）同层次的后面的节点
 
 2）同层次的前面的节点的孩子节点（因为遍历前面的节点时，会弹出节点，同时将孩子节点压入队列）
 
 通过上面的分析，我们可以设置一个标志位flag，当子树满足完全二叉树时，设置flag=YES。当flag=YES而节点又破坏了完全二叉树的条件，那么它就不是完全二叉树。
 
 */

/**
 *  是否完全二叉树
 *  完全二叉树：若设二叉树的高度为h，除第h层外，其它各层的结点数都达到最大个数，第h层有叶子结点，并且叶子结点都是从左到右依次排布
 *
 *  @param rootNode 根节点
 *
 *  @return YES：是完全二叉树，NO：不是完全二叉树
 */
+ (BOOL)isCompleteBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return NO;
    }
    //左子树和右子树都是空，则是完全二叉树
    if (!rootNode->left && !rootNode->right) {
        return YES;
    }
    //左子树是空，右子树不是空，则不是完全二叉树
    if (!rootNode->left && rootNode->right) {
        return NO;
    }
    
    //按层次遍历节点，找到满足完全二叉树的条件：
    //条件1：如果某个节点的右子树不为空，则它的左子树必须不为空
    //条件2：如果某个节点的右子树为空，则排在它后面的节点必须没有孩子节点
    //排在该节点后面的节点有2种：1）同层次的后面的节点 2）同层次的前面的节点的孩子节点（因为遍历前面的节点的时候，会将节点从队列里pop，同时把它的孩子节点push到队列里）
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:rootNode];
    BOOL isComplete = NO; //是否已经满足完全二叉树
    while (queue.count > 0) {
        BinaryTreeNode *node = [queue firstObject];
        [queue removeObjectAtIndex:0];
        
        //左子树为空且右子树不为空，则不是完全二叉树
        if (!node->left && node->right) {
            return NO;
        }
        if (isComplete && (node->left || node->right)) {
            //前面的节点已满足完全二叉树,如果还有孩子节点，则不是完全二叉树
            return NO;
        }
        
        //右子树为空，则已经满足完全二叉树
        if (!node->right) {
            isComplete = YES;
        }
        
        //压入
        if (node->left) {
            [queue addObject:node->left];
        }
        if (node->right) {
            [queue addObject:node->right];
        }
    }
    return isComplete;
}

/*****************判断二叉树是否满二叉树******************/

/*
 
 满二叉树定义为：除了叶结点外每一个结点都有左右子叶且叶子结点都处在最底层的二叉树
 
 满二叉树的一个特性是：叶子数=2^(深度-1)，因此我们可以根据这个特性来判断二叉树是否是满二叉树。
 
 *  是否满二叉树
 *  满二叉树：除了叶结点外每一个结点都有左右子叶且叶子结点都处在最底层的二叉树
 *
 *  @param rootNode 根节点
 *
 *  @return YES：满二叉树，NO：非满二叉树
 
 */

+ (BOOL)isFullBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return NO;
    }
    
    //二叉树深度
    NSInteger depth = [self depthOfTree:rootNode];
    //二叉树叶子节点数
    NSInteger leafNum = [self numberOfLeafsInTree:rootNode];
    
    //满二叉树特性：叶子数=2^(深度-1)
    if (leafNum == pow(2, (depth - 1))) {
        return YES;
    }
    return NO;
}

/*****************判断二叉树是否满二叉树******************/

/*
 
 平衡二叉树定义为：它是一棵空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树。平衡二叉树又叫AVL树。
 
 *  是否平衡二叉树
 *  平衡二叉树：即AVL树，它是一棵空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树
 *
 *  @param rootNode 根节点
 *
 *  @return YES：平衡二叉树，NO：非平衡二叉树
 
 */

+ (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode {
    static NSInteger height;
    if (!rootNode) {
        height = 0;
        return YES;
    }
    if (!rootNode->left && !rootNode->right) {
        height = 1;
        return YES;
    }
    
    BOOL isAVLLeft = [self isAVLBinaryTree:rootNode->left];
    NSInteger heightLeft = height;
    BOOL isAVLRight = [self isAVLBinaryTree:rootNode->right];
    NSInteger heightRight = height;
    
    height = MAX(heightLeft, heightRight)+1;
    
    if (isAVLLeft && isAVLRight && ABS(heightLeft-heightRight) <= 1) {
        return YES;
    }
    return NO;
}



@end




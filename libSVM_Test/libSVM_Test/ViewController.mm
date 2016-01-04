//
//  ViewController.m
//  libSVM_Test
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ViewController.h"
#import "svm.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    struct svm_node *pa0 = new svm_node();
    pa0->index = 0;
    pa0->value = 175.0;
    struct svm_node *pa1 = new svm_node();
    pa1->index = -1;
    pa1->value = 65.0;
    struct svm_node *pb0 = new svm_node();
    pb0->index = 0;
    pb0->value = 160.0;
    struct svm_node *pb1 = new svm_node();
    pb1->index = -1;
    pb1->value = 45.0;
    struct svm_node pa[] = {*pa0, *pa1};
    struct svm_node pb[] = {*pb0, *pb1};
    struct svm_node* datas[] = {pa, pb};
    double lables[] = {1.0, -1.0};
    
    //定义svm_problem对象
    struct svm_problem *problem = new svm_problem();
    problem->l = 2;
    problem->x = datas;
    problem->y = lables;
    
    //定义svm_parameter对象
    struct svm_parameter *param = new svm_parameter();
    param->svm_type = C_SVC;
    param->kernel_type = LINEAR;
    param->cache_size = 100;
    param->eps = 0.00001;
    param->C = 1;
    
    //训练SVM分类模型
    NSLog(@"%s",svm_check_parameter(problem, param));
    struct     svm_model *model = svm_train(problem, param);
    
    //定义测试数据点c
    struct svm_node *pc0 = new svm_node();
    pc0->index = 0;
    pc0->value = 165;
    struct svm_node *pc1 = new svm_node();
    pc1->index = -1;
    pc1->value = 55;
    struct svm_node pc[] = {*pc0, *pc1};
    
    //预测测试数据的lable
    NSLog( @"%lf",svm_predict(model, pc));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

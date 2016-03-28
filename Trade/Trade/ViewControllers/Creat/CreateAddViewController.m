//
//  CreateAddViewController.m
//  Trade
//
//  Created by Yuyangdexue on 15/10/29.
//  Copyright © 2015年 yuyang. All rights reserved.
//

#import "CreateAddViewController.h"
#import "Constants.h"
#import "CreateTitleModel.h"
#import "App.h"
#import "CreateContentViewController.h"

#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
@interface CreateAddViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UIImageView *_imageView;
    UIView      *_bottomView;
    UIView      *_selectImageView;
    UITextField *_titleTextField;
    UIImagePickerController *imagePicker;
    UIImage *theImage;
    CreateTitleModel *model;
    UIScrollView *_scrollView;

    
}
@property (nonatomic,strong) NSString *upKey;
@end

@implementation CreateAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeLeftImage:nil title:@"" rightString:@"下一步"];
    
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.imageView];
    [_scrollView addSubview:self.bottomView];
    [_scrollView addSubview:self.selectImageView];

    // Do any additional setup after loading the vie w.
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, kDeviceWidth, kDeviceHeight-50)];
        _scrollView.backgroundColor=[UIColor whiteColor];
        
    }
    return _scrollView;
}

- (void)rightClick
{
    [self titleHttp];
//    CreateContentViewController *vc=[[CreateContentViewController alloc]initWithAlbumId:@"1"];
//    [self pushVController:vc];
 
   
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 300)];
        _imageView.backgroundColor=kColor_e8e8e8_Color;
    }
    return _imageView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 300, kDeviceWidth, kDeviceHeight-350)];
        _bottomView.backgroundColor=[UIColor whiteColor];
        
        [_bottomView addSubview:self.titleTextField];
        
        
        UIImageView *avatarImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];;
        avatarImageView.layer.masksToBounds=YES;
        avatarImageView.layer.cornerRadius=20;

        avatarImageView.image=[UIImage imageNamed:@"avatardefault@2x.png"];
        avatarImageView.center=CGPointMake(kDeviceWidth/2,20+25+50+20);
        
        [_bottomView addSubview:avatarImageView];
        
        UILabel *nameLable=[UILabel labelWithRect:CGRectMake(0,20+25+50+40+20, kDeviceWidth, 15) text:@"用户" textColor:[UIColor blackColor] fontSize:12 textAlignment:NSTextAlignmentCenter];
        
        [_bottomView addSubview:nameLable];
        
        
    }
    return _bottomView;
}


- (UITextField *)titleTextField
{
    if (!_titleTextField) {
        _titleTextField=[UITextField  textFieldWithRect:CGRectMake(0, 50, kDeviceWidth, 20) text:@"标题" placeholder: nil textColor:[UIColor blackColor] fontSize:16 textAlignment:NSTextAlignmentCenter];
        
    }
    return _titleTextField;
}


- (UIView *)selectImageView
{
    if (!_selectImageView) {
        _selectImageView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 140, 40)];
        _selectImageView.backgroundColor=[UIColor whiteColor];
        _selectImageView.center=CGPointMake(kDeviceWidth/2, 150);
        
        UIImageView *photoImage=[[UIImageView alloc]initWithFrame:CGRectMake(14, 10, 20, 20)];
        photoImage.image=[UIImage imageNamed:@"photo_dark@2x.png"];
        [_selectImageView addSubview:photoImage];
        
        UILabel *lable=[UILabel labelWithRect:CGRectMake(14+20+10, 10, 140-30, 20) text:@"选择图片封面" textColor:[UIColor blackColor] fontSize:14 textAlignment:NSTextAlignmentLeft];
        
        [_selectImageView addSubview:lable];
        _selectImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        [_selectImageView addGestureRecognizer:tap];
    }
    return _selectImageView;
}

- (void)clickImage
{
    [self pickImageFromAlbum];
}


- (void)resetUI:(CGFloat)height;
{
    _imageView.image=theImage;
    _imageView.frame=CGRectMake(0, 0, kDeviceWidth, height);
    _selectImageView.center=CGPointMake(kDeviceWidth/2, height/2);
    _bottomView.frame=CGRectMake(0, height, kDeviceWidth, 208);
    if (height+208<=kDeviceHeight-50) {
           _scrollView.contentSize=CGSizeMake(kDeviceWidth, kDeviceHeight-50);
    }
    else
    {
           _scrollView.contentSize=CGSizeMake(kDeviceWidth, height+208);
    }
 
    
}


#pragma mark 从用户相册获取图片

- (void)pickImageFromAlbum
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    
    NSLog(@"123123");
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"123123 Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    float height=kDeviceWidth*image.size.height/image.size.width;
    
    theImage=image;
    [self resetUI:height];
    //theImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(120.0, 120.0)];
    
    //[_avatarBtn setImage:theImage forState:UIControlStateNormal];
    
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    __weak CreateAddViewController *weakSelf=self;
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *fileName = [representation filename];
        NSLog(@"fileName : %@",fileName);
        weakSelf.upKey=[App getUpPhotoName:fileName];
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}



#pragma mark http title
- (void)titleHttp
{
    if ([_titleTextField.text length]==0) {
        return;
    }
    [self showLoading];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    [dic setObject:_titleTextField.text forKey:@"title"];
    
    [self postRequestParam:dic AppURL:AppURL_Album_Uploadtoken isHead:YES CompleteBlock:^(NSDictionary *dic) {
        
        if ([dic isKindOfClass:[NSDictionary class]]) {
            if ([dic intForKey:@"code"]==1) {
                NSDictionary *data=[dic dictionaryForKey:@"data"];
                model=[[CreateTitleModel alloc]initWithDictionary:data error:nil];
                
                
                if (model) {
                NSData *imageData = UIImagePNGRepresentation(theImage);
//                    [self uploadImage:model.upToken data:imageData];
                    [App uploadImage:model.upToken key:self.upKey data:imageData completeBlock:^(NSDictionary *dic) {
                        
                    } errorBlock:^(NSError *error) {
                        
                    }];
                    if (model.albumId) {
                        CreateContentViewController *vc=[[CreateContentViewController alloc]initWithAlbumId:model.albumId];
                        [self pushVController:vc];
                        [self hideLoading];
                    }
                }
            }
            
        }
        
    } errorBlock:^(NSError *error) {
         [self hideLoading];
        
    }];
}

#pragma mark qiniu






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

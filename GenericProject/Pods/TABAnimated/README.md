<div style="align: center">
<img src="https://upload-images.jianshu.io/upload_images/5632003-14498d8a6c786224.png"/>
</div>

<p style="align: center">
    <a href="https://github.com/tigerAndBull/TABAnimated">
       <img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic">
    </a>
    <a href="https://github.com/tigerAndBull/TABAnimated">
       <img src="https://img.shields.io/badge/language-objective--c-blue.svg">
    </a>
    <a href="https://cocoapods.org/pods/TABAnimated">
       <img src="https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic">
    </a>
    <a href="https://github.com/tigerAndBull/TABAnimated">
       <img src="https://img.shields.io/badge/support-ios%208%2B-orange.svg">
    </a>
</p>

> + [English Documents](https://github.com/tigerAndBull/TABAnimated/blob/master/README_EN.md)

## 骨架屏是什么？

找到这里的同志，或多或少都对骨架屏有所了解，请容许我先啰嗦一句。骨架屏(Skeleton Screen)是一种优化用户弱网体验的方案，可以有效缓解用户等待的焦躁情绪。

## TABAnimated是什么？

TABAnimated是提供给iOS开发者自动生成骨架屏的一种解决方案。开发者可以将已经开发好的视图，通过TABAnimated配置一些全局/局部的参数，自动生成与其长相一致的骨架屏。
当然，TABAnimated会协助你管理骨架屏的生命周期。

## 目录

* [集成优势](#集成优势)
* [效果展示](#效果展示)
* [演示过程](#演示过程)  
* [集成步骤](#集成步骤)
* [问题检索](#问题检索)
* [最后强调](#最后强调)

## 集成优势

通过TABAnimated集成的骨架屏有什么优势？

-  是一种自动化方案，集成速度非常快
-  零耦合，易于将其动画逻辑封装到基础库，且移除方便
-  配有缓存功能，压测切换控制器不卡顿
-  适用场景广，可以适用开发中99.99%的视图
-  自由度非常高，可以完全地自定制，包括动画及其序列化
-  自动切换暗黑模式骨架屏
-  支持上拉加载更多
-   配合InjectionIII支持实时预览

## 效果展示

| 闪光动画 | 经典动画 | 下坠动画 | 
| ------ | ------ | ------ | 
| ![闪光动画.gif](https://upload-images.jianshu.io/upload_images/5632003-8ebdc1e964fcfbb5.gif?imageMogr2/auto-orient/strip) | ![经典动画.gif](https://upload-images.jianshu.io/upload_images/5632003-8025a04102572ed4.gif?imageMogr2/auto-orient/strip) | ![下坠动画.gif](https://upload-images.jianshu.io/upload_images/5632003-5277740f43880cde.gif?imageMogr2/auto-orient/strip) | 

| 呼吸动画 | 上拉加载 | 复杂场景 |
| ------ | ------ | ------ | 
| ![呼吸动画.gif](https://upload-images.jianshu.io/upload_images/5632003-8edf170c90e18b4b.gif?imageMogr2/auto-orient/strip)| ![上拉加载.gif](https://upload-images.jianshu.io/upload_images/5632003-72265e19c84fe415.gif?imageMogr2/auto-orient/strip) | ![复杂场景.gif](https://upload-images.jianshu.io/upload_images/5632003-e5500766b4f66f14.gif?imageMogr2/auto-orient/strip) | 

**暗黑模式：**

| 工具箱切换 | setting页面切换 |
| ------ | ------ | 
| ![工具箱切换.gif](https://upload-images.jianshu.io/upload_images/5632003-cf5c4f50eac6fe6c.gif?imageMogr2/auto-orient/strip) | ![setting设置切换.gif](https://upload-images.jianshu.io/upload_images/5632003-2d1fb96ec07d6bca.gif?imageMogr2/auto-orient/strip) | 

**实时预览：**

![实时预览.gif](https://upload-images.jianshu.io/upload_images/5632003-4161e026819b7739.gif?imageMogr2/auto-orient/strip)

## 演示过程

下面通过一个小例子，更深入地了解一下TABAnimated。

#### 1. 小明和小张有一个下图这样的视图，需要集成骨架屏

![需求.png](https://upload-images.jianshu.io/upload_images/5632003-8bb0895de7690f79.png?imageMogr2/auto-orient/strip%7CimageView2/3/w/300)

#### 2. 下面是通过TABAnimated自动化生成的效果

![自动化生成.png](https://upload-images.jianshu.io/upload_images/5632003-f10c2427f8b149ba.png?imageMogr2/auto-orient/strip%7CimageView2/3/w/300)

#### 3. 小明做这个需求说，这个效果我很满意，那么小明的工作到此就结束了。但是小张说，我感觉长度，高度，虽然和原视图很像，但是作为一种动画效果我不太满意，不够精致。于是，他通过（预处理回调+链式语法），很快地做了如下调整。

![调整后效果.png](https://upload-images.jianshu.io/upload_images/5632003-0affe19065135d31.png?imageMogr2/auto-orient/strip%7CimageView2/3/w/300)

当然啦，每个人有不同的审美，每个产品有不同的需求，这些就全交由你来把握啦～

## 集成步骤

### 一、导入到工程中

- CocoaPods

```
pod 'TABAnimated', '2.5.0'
```

- Carthage

```
github "tigerAndBull/TABAnimated"
```

- 将TABAnimated文件夹拖入工程

**注意: 在github上下载的演示demo，为了很好的模拟真实的应用场景，使用了一些大家都熟悉的第三方，但是TABAnimated自身并不依赖他们。**

### 二、全局参数初始化

在 `didFinishLaunchingWithOptions` 中初始化 `TABAimated`

```
[[TABAnimated sharedAnimated] initWithOnlySkeleton];
[TABAnimated sharedAnimated].openLog = YES;
```

**注意：还有其他的动画类型、全局属性，在框架中都有注释。**

### 三、控制视图初始化

**控制视图：如果是列表视图，那么就是UITableView/UICollectionView，有文档具体讲解。**

`NewsCollectionViewCell`就是你列表中用到的cell，当然你要绑定其他cell，也是完全可以的！

```
_collectionView.tabAnimated = 
[TABCollectionAnimated animatedWithCellClass:[NewsCollectionViewCell class] 
cellSize:[NewsCollectionViewCell cellSize]];
```

**注意：**

- **有其他初始化方法，比如常见的多种cell，在框架中都有注释**
- **有针对这个控制视图的局部属性，在框架中都有注释**

### 四、控制骨架屏开关

1. 开启动画

```
[self.collectionView tab_startAnimation];  
```

2. 关闭动画

```
[self.collectionView tab_endAnimation];
```

### 五、刚刚说到的，预处理回调+链式语法怎么用？

```
_tableView.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
    manager.animation(1).down(3).radius(12);
    manager.animation(2).height(12).width(110);
    manager.animation(3).down(-5).height(12);
};
```

#### 1. 有的人看到上面，可能一下子就被吓到了，集成需要这么复杂吗？

答：需不需要异步调整，需要调整到什么程度，与你自身约束、产品需求，都有关系。所以并不能自动生成让任何产品、任何人立即都完全满意的效果。
你大可放心，推出这个功能反而是协助开发者更快速调整自己想要的结果。**

#### 2. `manager.animation(x)`，x是多少？

答：在appDelegate设置TABAnimated的`openAnimationTag`属性为YES，框架就会自动为你指示，究竟x是几
```
[TABAnimated sharedAnimated].openAnimationTag = YES;
```

#### 3. 通过几个示例，具体了解（预处理回调+链式语法）

- 假如第0个元素的高度和宽度不合适
```
manager.animation(0).height(12).width(110);
```
- 假如第1个元素需要使用占位图
```
manager.animation(1).placeholder(@"占位图名称.png");
```
- 假如第1，2，3个元素宽度都为50
```
manager.animations(1,3).width(50);
```
- 假如第1，5，7个元素需要下移5px
```
manager.animationWithIndexs(1,5,7).down(5);
```

![下标示意图.png](https://upload-images.jianshu.io/upload_images/5632003-2842bd54e80dd9ef.png?imageMogr2/auto-orient/strip%7CimageView2/3/w/300)

#### 表格集成必看

(1) 在你集成表格视图之前，一定要理清你自己的视图结构：

分为以下三种

+ 以section为单元，section和cell样式一一对应
+ 视图只有1个section, 但是对应多个cell
+ 动态section：你的section数量是网络获取的

(2) 明白你自己的需求：

+ 设置多个section/row，一起开启动画
+ 设置多个section/row，部分开启动画

(3) 最后到框架内找到对应的初始化方法、启动动画方法即可！

## 问题检索

**当然啦，在实际应用中，我们还有各式各样的视图，TABAnimated经历了很多产品的考验，统统都可以应对。
但是光凭上面的知识肯定是不够的，以下是更详细说明文档。**

- 最好要阅读的文档：

> + [缓存策略和线程处理](https://github.com/tigerAndBull/TABAnimated/blob/master/Documents/%E7%BC%93%E5%AD%98%E7%AD%96%E7%95%A5%E5%92%8C%E7%BA%BF%E7%A8%8B%E5%A4%84%E7%90%86.md)
> + [架构设计和性能测试](https://github.com/tigerAndBull/TABAnimated/blob/master/Documents/%E6%9E%B6%E6%9E%84%E8%AE%BE%E8%AE%A1%E5%92%8C%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95.md)

- 集成最可能用到的文档：

> + [预处理回调动画元素下标问题](https://github.com/tigerAndBull/TABAnimated/blob/master/Documents/%E5%8A%A8%E7%94%BB%E5%85%83%E7%B4%A0%E4%B8%8B%E6%A0%87%E9%97%AE%E9%A2%98.md)
> + [问题答疑文档](https://github.com/tigerAndBull/TABAnimated/blob/master/Documents/%E9%97%AE%E9%A2%98%E7%AD%94%E7%96%91%E6%96%87%E6%A1%A3.md)、[版本信息记录文档](https://github.com/tigerAndBull/TABAnimated/blob/master/Documents/%E5%8D%87%E7%BA%A7%E6%96%87%E6%A1%A3%E5%92%8C%E5%85%B6%E4%BB%96%E4%BF%AE%E5%A4%8D.md)
> + [全局:局部属性、链式语法api](https://github.com/tigerAndBull/TABAnimated/blob/master/Documents/%E5%85%A8%E5%B1%80:%E5%B1%80%E9%83%A8%E5%B1%9E%E6%80%A7%E3%80%81%E9%93%BE%E5%BC%8F%E8%AF%AD%E6%B3%95api.md)

- 可能用到的其他技术文档

> + [豆瓣动画详解](https://github.com/tigerAndBull/TABAnimated/blob/master/Documents/%E8%B1%86%E7%93%A3%E5%8A%A8%E7%94%BB%E8%AF%A6%E8%A7%A3.md)
> + [不再hook setDelegate和setDataSource](https://github.com/tigerAndBull/TABAnimated/blob/master/Documents/%E4%B8%8D%E5%86%8Dhook%20setDelegate%E5%92%8CsetDataSource.md)
> + [上拉加载更多](https://github.com/tigerAndBull/TABAnimated/blob/master/Documents/%E4%B8%8A%E6%8B%89%E5%8A%A0%E8%BD%BD%E5%8A%9F%E8%83%BD.md)

**如果你仍无法解决问题，可以尽快联系我，我相信TABAnimated是可以解决99%的需求的**

## 最后强调

- 有问题一定要先看`demo`和文档哈，demo的示例分散在`UITableView`和`UICollectionView`两种类型视图上
- demo也只是引导的作用，你可以自己设置出更精美的效果
- 如有使用问题、优化建议、好的想法等，可以关注公众号：tigerAndBull技术分享，扫码加群快速解决

## License

All source code is licensed under the [License](https://github.com/tigerAndBull/TABAnimated/blob/master/LICENSE)


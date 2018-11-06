//顺序存储结构 转换成 二叉链存储结构
BTNode *trans1(SqBTtree a, int i)
{
    BTNode *b;
    if(i > MaxSize) 
        return NULL;
    if(a[i] == '#')
        return NULL; //当节点不存在时候

    b = (BTNode *)malloc(sizeof(BTNode)); //创建节点
    b->data = a[i];
    b->lchild = trans1(a, 2 * i); //递归创建左子树
    b->rchild = trans1(a, i * 2 + 1); //递归创建右子树

    return b;  //返回节点
}

//二叉链存储结构 转换成 顺序存储结构
void *trans2(BTNode *b, SqBTree a, int i)
{
    if(b != NULL)
    {
        a[i] = b->data;
        trans2(b->lchild, a, 2 * i);
        trans2(b->rchild, a, 2 * i + 1);
    }
}


//线索化二叉树节点类型
typedef struct node
{
    ElemType data;
    int ltag, rtag;  //增加的线索标记，0：左右孩子，1：前驱或者后继
    struct node *lchild; //左孩子或线索指针
    struct node *rchild; //右孩子或线索指针
}TBTNode;

TBTNode *pre; //全局变量
TBTNode *CreateThread(TBTNode *b) //中序线索化二叉树
{
    TBTNode *root;
    root = (TBTNode *)malloc(sizeof(TBTNode));
    root->ltag = 0; 
    root->rtag = 1;
    root->rchild = b;

    if(b == NULL) //空二叉树
    {
        root->lchild = root;
    }
    else
    {
        root->lchild = b;
        pre = root;               //pre是*p的前趋节点，供加线索用
        Thread(b);                //中序遍历线索化二叉树
        pre->rchild = root;       //最后处理，加入指向头节点的线索
        pre->rtag = 1;
        root->rchild = pre;       //头节点右线索化
    }
        
    return root;
}

void Thread(TBTNode *&p) //对二叉树b进行中序线索化
{
    if(p != NULL)
    {
        Thread(p->lchild); //左子树线索化 
        
        if(p->lchild == NULL) //前趋线索化
        {
            p->lchild = pre;
            p->ltag = 1;
        }
        else
        {
            p->ltag = 0;
        }

        if(pre->rchild == NULL) //后继线索化
        {
            pre->rchild = p;
            pre->rtag = 1;
        }
        else
        {
            pre->rtag = 0;
        }
        pre = p;

        Thread(p->rchild); //递归调用右子树线索化
    }
}

//中序遍历线索二叉树
void ThInOrder(TBTNode *tb)
{
    TBTNode *p = tb->lchild;
    while(p != tb)
    {
        while(p->ltag == 0)
            p = p->lchild;
        print("%c", p->data);

        while(p->rtag == 1 && p->rchild != tb)
        {
            p = p->rchild;
            print("%c", p->data);
        }
        
        p = p->rchild;
    }
}

#int size();
# boolean isEmpty();
# void clear();
# void add(E element);
# void remove(E element);
# boolean constains(E element);
# /** 遍历所有元素（必须按照元素从小到大的顺序遍历） */
# void traversal(Visitor<E> visitor);

#
class Tree_Set:
    def __init__(self):
        self.size = 0
        self.root = None
    def _size(self):
        #大小
        return self.size

    def add(self, item):
        #增加元素 如果是根结点 则新增； 先判断是否存在 如不存在则新增
        if (self.root == None):
            self.root = TreeNode(item)
            self.size += 1
            return True
        else:
            if (self.contains(item) == False):
                self._insert(item, self.root)
                self.size += 1
                return True

    def _insert(self, item, node):
        # 根据BTS的规则 插入新的节点
        compare = item< node.data
        if (compare == 1):
            if (node.left != None):
                self._insert(item, node.left)
            else:
                node.left = TreeNode(item)
        elif (compare == 0):
            if (node.right != None):
                self._insert(item, node.right)
            else:
                node.right = TreeNode(item)
        else:
            return False

    def remove(self, item):
        if self.root == None:
            return False
        elif self.root:
            if (self.contains(item) == True):
                self.size -= 1
                self.root = self.root.remove(item)
                return True

    def contains(self, item):
        return self.find_node(self.root, item)

    def find_node(self, current, item):
        if (current is None):
            return False
        elif (item == current.data):
            return True
        elif (item < current.data):
            return self.find_node(current.left, item)
        else:
            return self.find_node(current.right, item)
    def clear(self):
        self.size = 0
        self.root = None
    def is_empty(self):
        return self._size() == 0

    def traversal(self,visitor):
        visitor.visit(self.root)

class TreeNode:
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None

    def remove(self, data):
        #删除节点的操作
        # 1.首先找到待删除的节点
        # 2.
        if self.data is None:
            return self
        if data < self.data:
            self.left = self.left.remove(data)
        elif data > self.data:
            self.right = self.right.remove(data)
        else:
            if self.left is None:
                val = self.right
                self.data = None
                return val

            elif self.right is None:
                val = self.left
                self.data = None
                return val
            val = self._findMin(self.right)
            self.data = val.data
            self.right = self.right.remove(val.data)
        return self

    def _findMin(self, node):
        current = node
        while (current.left is not None):
            current = current.left

        return current

class visitor():
    # 定义visitor类 在其中包含具体遍历方法
    def __init__(self):
        self.stop = False
    def intermediateTraversal(self,node):
        # 因为顺序采用由小到大 所以用中序遍历
        if node == None:
            return
        self.intermediateTraversal(node.left)
        print(node.data)
        self.intermediateTraversal(node.right)
        return
    def visit(self,node):
        self.intermediateTraversal(node)


# 以下为测试使用
tree=Tree_Set()
visitor=visitor()
tree.add(10)
tree.add(3)
tree.add(2)
tree.add(8)
tree.add(8)
tree.add(15)
tree.remove(2)
print("包含元素个数为：",tree._size())
print("是否含有元素20:",tree.contains(20))
print("遍历")
tree.traversal(visitor)
print("清空")
tree.clear()
print("当前是否为空:",tree.is_empty())




# 需要有以下接口
#int size(); 返回储存数据个数
# boolean isEmpty(); 是否为空
# void clear(); 清空整个map
# V put(K key, V value); 新增键值对
# V get(K key); 根据键获取值
# V remove(K key); 根据键 删除键值对
# boolean containsKey(K key); 是否含指定键
# boolean containsValue(V value); 是否含指定值
# void traversal(Visitor<K, V> visitor); 便利打印所有的键值对

class Node:
    ## 定义链表中的节点
    def __init__(self, key, val, prev=None, succ=None):
        self.key = key
        self.val = val
        # 前驱
        self.prev = prev
        # 后继
        self.succ = succ

class LinkList:
    ## 定义 链表 类
    def __init__(self):
        self.head = Node(None, 'header')
        self.tail = Node(None, 'tail')
        self.head.succ = self.tail# 头尾相接
        self.tail.prev = self.head # 头尾相接
        self.size = 0

    def add(self, node):
        # 将node节点添加在链表尾部 新增
        prev = self.tail.prev
        node.prev = prev
        node.succ = prev.succ
        prev.succ = node
        node.succ.prev = node
        self.size += 1

    def delete(self, node):
        # 删除节点
        prev = node.prev
        succ = node.succ
        succ.prev=prev
        prev.succ =succ
        self.size -= 1

    def get_by_key(self, key):
        cur = self.head.succ
        while cur != self.tail:
            if cur.key == key:
                return cur
            cur = cur.succ
        return None

    def _containsKey(self, key):
        # 在一条链表上遍历查找
        curr = self.head.succ
        while curr != self.tail:
            if curr.key == key:
                return True
            curr = curr.succ
        return False
    def _containsValue(self, value):
        # 在一条链表上遍历查找
        curr = self.head.succ
        while curr != self.tail:
            if curr.val == value:
                return True
            curr = curr.succ
        return False




class HashMap:
    # HashMap 是由链表组成的定长数组（非动态）
    def __init__(self, capacity=16, load_factor=5):
        self.capacity = capacity
        self.load_factor = load_factor
        self.headers = [LinkList() for _ in range(capacity)] #初始化这个数组

    def get_hash_key(self, key):
        # 获取哈希值 判断加到哪个链表之中
        return hash(key) & (self.capacity - 1)
    def is_Empty(self):
        for link_list in self.headers:
            if link_list.size>0:
                return False
        return True
    def clear(self):
        self.headers = [LinkList() for _ in range(self.capacity)] #重新初始化这个数组 相当于清空
        self.size=0

    def put(self, key, val):
        hash_key = self.get_hash_key(key)
        linked_list = self.headers[hash_key]
        node = linked_list.get_by_key(key) #先看有没有
        if node is not None:
            node.val = val #更新值
        else: #如果之前没有 则新增
            node = Node(key, val)
            linked_list.add(node)

    def get(self, key):
        hash_key = self.get_hash_key(key)
        linked_list = self.headers[hash_key]
        node = linked_list.get_by_key(key)
        if node is not None:
            #print("查询到的value:",node.val)
            return node
        else:
            return None
    def containsKey(self,key):
        hash_key = self.get_hash_key(key)
        linked_list = self.headers[hash_key]
        return linked_list._containsKey(key)


    def containsValue(self,value):
        for linked_list in self.headers:
            if linked_list._containsValue(value):
                return True
        return False
    def remove(self, key):
        node = self.get(key)
        if node is None:
            return False
        hash_key = self.get_hash_key(key)
        linked_list = self.headers[hash_key]
        linked_list.delete(node)
        return True
    def traversal(self,visitor):
        visitor.visit(self.headers)
class visitor:
    # 定义visitor类 在其中包含具体遍历方法
    def __init__(self):
        self.stop=False
    def _traversal(self,link_list):
        curr = link_list.head.succ
        while curr !=link_list.tail:
            print("Key:",curr.key,"Value:",curr.val)
            curr = curr.succ
    def visit(self,headers):
        for linked_list in headers:
            self._traversal(linked_list)

Map=HashMap()
visitor=visitor()
Map.put("a",1)
Map.put("b",2)
Map.put("c",3)
Map.put("d",4)
Map.put("e",5)
Map.put("f",6)
Map.remove('f')
print("是否包含key：'e'",Map.containsKey('e'))
print("是否包含value：6",Map.containsValue(6))
print("是否为空",Map.is_Empty())
print("根据key查询:",Map.get("d").val)
print("遍历")
Map.traversal(visitor)
print("清空")
Map.clear()
print("当前是否为空：",Map.is_Empty())


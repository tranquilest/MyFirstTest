function Event()
    -- 选中toggle
    AddListener(select_item, OnItemSelection)
    -- 列表变化
    AddListener(list_change, OnChangeListStatus)

end

function ctor()
    self._friendsData = nil
    self._selectToggle = nil
    self._dropDownIndex = nil

    self._gridViewList = nil

    self._chatUserGuid = nil
end

-- 初始化
function Init()
    self._friendsData = RoleManager.Me:GetFriendsData()

    -- 对gridview创建和初始化
    self._gridViewList = new GridView()
    self._gridViewList:Init()
    -- 

end
-- 正常点击好友界面打开刷新
function InitFromNormal()
    self:RefreshItemList(opListType)
    self:SetItemSelection(defalutIndex) -- default 定义uiconst中，此处默认为1

end
-- 点击交互子界面
function InitFromTalk()
end
-- 从“添加好友”切换回来
function InitFromHide()
end

-- 刷新好友列表中item
function RefreshItemList(opListType)
    -- 通过opListType在FriendsData中找到数据
    for i = 1, itemNumber do
        local item = self._gridViewList:AddItem(i)
        if item then
            item:RefreshUI(opListType, i)
        end
    end

    -- 隐藏多余item时候，把toggle选中状态去掉
    local gridViewListLength = self._gridViewList:GetLength()
    for j = (itemNumber + 1), gridViewListLength do
        local item = self._gridViewList:AddItem(i)
        if item then
            item:_selectToggle(false)
        end
    end
    
    self._gridViewList:HideRange(itemNumber + 1)

end 

-- 选中指定toggle
function SetItemSelection(selectIndex)
    local item = self._gridViewList:GetItem(selectIndex)
    if item then
        item:SetToggle(true)
    else
        -- 如果没有item，则隐藏ChatPanel
        self:RefreshChatPanel(true)
    end

end

-- 响应选中toggle
function OnItemSelection(opListType, index)
    local list -- friends中list
    self:RefreshChatPanel(false)

end

-- 刷新聊天界面
function RefreshChatPanel(hopeHide, opListType, chatUserGuid)
    -- 不希望显示，则隐藏并返回
    if not hopeHide then
        self._chatUserGuid = nil
        chatPanel.gameObject:SetActive(false)
        return 
    end

    -- 希望显示，但检查是黑名单则隐藏chatPanel
    -- 如果是黑名单，则隐藏并提示黑名单中无法聊天
    if opListType == blackList then
        self._chatUserGuid = nil
        chatPanel.gameObject:SetActive(false)
        return         
    end

    -- 设置聊天对象文字
    local chatUserName = self._friendsData:GetElement():GetUserName(chatUserGuid)
    slef._toChatText.text = g_langText:Get("", {name = chatUserName})
    
    -- 刷新聊天内容
    self._chatUserGuid = chatUserGuid
    chatPanel.gameObject:SetActive(true)
    self:RefreshChat()  -- 刷新放在显示后面，因为有强刷
    

end

-- 刷新聊天信息
function RefreshChat()

end

-- 响应List变换
function OnChangeListStatus()

end
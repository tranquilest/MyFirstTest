function item:ctor()
    self._index = nil
    self._opListType = nil
end

function item:OnToggleChange(value)
    if value then
        -- 
    end

end

function item:SetToggle(isOn)
    self._toggle.isOn = isOn
end

function item:SetItem(opListType, i)

end
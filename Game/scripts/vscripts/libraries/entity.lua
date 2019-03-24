function CDOTA_BaseNPC:ClearInventory()
	local item_count = self:GetNumItemsInInventory()
	for i=0, item_count do
		local item = self:GetItemInSlot(i)
		self:RemoveItem(item)
	end
end

function CDOTA_BaseNPC:GetCollisionSize()
	if GetUnitKV(self:GetUnitName()) then
		return GetUnitKV(self:GetUnitName(),"CollisionSize")
	end
	return nil
end
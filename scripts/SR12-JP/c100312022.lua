--Chorus in the Sky
--coded by Lyris
function c100312022.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,100312022+EFFECT_COUNT_CODE_OATH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c100312022.cost)
	e1:SetTarget(c100312022.target)
	e1:SetOperation(c100312022.activate)
	c:RegisterEffect(e1)
end
function c100312022.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c100312022.thfilter1(c)
	return c:IsRace(RACE_FAIRY) and c:IsAbleToHand()
end
function c100312022.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c100312022.thfilter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100312022.thfilter1,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c100312022.thfilter1,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c100312022.filter(c)
	return c:IsFaceup() and (c:IsCode(56433456) or aux.IsCodeListed(c,56433456)) and c:IsAbleToHand()
end
function c100312022.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) then
		local g=Duel.GetMatchingGroup(c100312022.filter,tp,LOCATION_REMOVED,0,nil)
		if (Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,56433456) or Duel.IsEnvironment(56433456))
			and #g>0 and Duel.SelectYesNo(tp,aux.Stringid(100312022,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sc=g:Select(tp,1,1,nil)
			Duel.BreakEffect()
			Duel.SendtoHand(sc,nil,REASON_EFFECT)
		end
	end
end

--!AddComponentMenu("")

-- Payments
type Payments =
{
    ClosePurchasePrompt: () -> (),
    PromptPurchase: (productId: string , callback: (boolean) -> ()) -> (),
}

-- PaymentsType
type PaymentsType =
{
    __tostring: () -> string,
}

if not _G.Payments then
    local PaymentsType_instance : PaymentsType = {}
    _G.Payments = PaymentsType_instance;
end

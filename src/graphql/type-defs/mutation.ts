export default `
type Mutation {
    createPet(pet: NewPet!): Pet!
    updatePet(id: String!, pet: UpdatedPet!): Pet!
    deletePet(id: String!): Pet!
}
`;
